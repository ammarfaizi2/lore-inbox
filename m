Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSHARbe>; Thu, 1 Aug 2002 13:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHARbe>; Thu, 1 Aug 2002 13:31:34 -0400
Received: from nameservices.net ([208.234.25.16]:36005 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S315784AbSHARbd>;
	Thu, 1 Aug 2002 13:31:33 -0400
Message-ID: <3D496F1F.56A1123A@opersys.com>
Date: Thu, 01 Aug 2002 13:25:51 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@actcom.co.il>
CC: Fabrizio Morbini <fabrizio.morbini@libero.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Tracing each new process...
References: <Pine.LNX.4.33L2.0208011340130.957-100000@localhost.localdomain> <3D496A33.2192F164@opersys.com> <20020801171303.GC7912@alhambra.actcom.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Muli Ben-Yehuda wrote:
> On Thu, Aug 01, 2002 at 01:04:51PM -0400, Karim Yaghmour wrote:
> >
> > Have a look at the Linux Trace Toolkit:
> > http://www.opersys.com/LTT/
> 
> syscalltrack, http://syscalltrack.sourceforge.net can do it as
> well. You'll get the notification in user space out of the box, and in
> kernel space with a bit of hacking.

Syscalltrack is only for tracking system calls. If the process creation
was requested from user-space, then indeed syscalltrack will show it.
It won't see kernel threads, among many other things. Not to mention
that it has to play around with the system call table to get its
information.

Now that you mention it, however, it is clear to me that syscalltrack
could definitely use the tracing framework provided by LTT in many
areas. First and foremost, it could get its system call information
using the existing trace hooks provided by LTT. In addition, instead
of implementing yet another event buffering framework, it could
use LTT's trace driver which already provides very efficient buffering.

Yet another reason to include LTT in the kernel.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
