Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129435AbRB1BXX>; Tue, 27 Feb 2001 20:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129564AbRB1BXN>; Tue, 27 Feb 2001 20:23:13 -0500
Received: from relay02.valueweb.net ([216.219.253.236]:64783 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S129435AbRB1BXI>; Tue, 27 Feb 2001 20:23:08 -0500
Message-ID: <3A9C544A.AB7B9071@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: "Collins, Tom" <Tom.Collins@Surgient.com>
CC: "'richardj_moore@uk.ibm.com'" <richardj_moore@uk.ibm.com>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: Dynamically altering code segments
In-Reply-To: <A490B2C9C629944E85CE1F394138AF957FC3E3@bignorse.SURGIENT.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Feb 2001 20:22:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Collins, Tom" wrote:
[snip]
> I have one more question:  My trace code is currently
> implemented as a kernel loadable module.  Would I need
> to change that so that it is built as part of the kernel,
> or can I keep it as a loadable module?  If I can keep it
> as a module, I would ensure that the module would be the
> only place that would enable/disable the trace, (don't
> want the kernel jumping to a nonexistant address :O  ..)
[snip]

No need to do that, except if you modify the binary dynamically.
If that's the case, then you'll probably have to make it part
of the kernel. But ... if you modify your code to use the
pre-existing hooks that come with LTT, you may not need to
modify anything more than what is provided with by the LTT
patch. That is, you may want to know that LTT provides a
hooking mechanism similar, but less flexible, than the one
GKHI provides. The advantage, though, is that there are pre-defined
hooks inserted with the LTT patch which can be used right
away without further instrumentation.

As this type of hooking comes more and more in need, I'm
currently discussing with Richard the possibility of using
the LTT pre-defined hooks with GKHI in order to provide an
extensible hooking mechanism for the kernel that comes equipped
with an already quite useful set of hooks, which, of course,
can be dynamically enabled/disabled.

Using this type of hooking, you only need to worry about
registering/unregistering your callbacks since the kernel
doesn't jump in your code, but in the hooks management code
first.

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
