Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270217AbTGSQwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 12:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270395AbTGSQwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 12:52:11 -0400
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:56583 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S270217AbTGSQwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 12:52:08 -0400
To: Christian Reichert <c.reichert@resolution.de>
Cc: John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
       linux-kernel@vger.kernel.org, lm@bitmover.com, rms@gnu.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Mail-Copies-To: nobody
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk>
	<1058626962.30424.6.camel@stargate>
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Sat, 19 Jul 2003 19:09:23 +0200
In-Reply-To: <1058626962.30424.6.camel@stargate> (Christian Reichert's
 message of "19 Jul 2003 17:02:41 +0200")
Message-ID: <plopm3lluu8mv0.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian!

19 Jul 2003 17:02:41 +0200, you wrote: 

 > On Sat, 2003-07-19 at 17:03, John Bradford wrote:
 >> > Given that large chunks of HURD come from Linux, please refer to it as
 >> > Linux/HURD.
 >> 
 >> What HURD code comes from Linux?  GNU/Mach uses code from Linux, but
 >> not HURD as far as I know.

 > Neither to my knowledge -

 > GNU/HURD uses GNU/MACH as the microkernel (and GNU/MACH uses Linux 2.0
 > drivers), but they are actually thinking of switching to another MACH
 > implementation once it's stable.

To be more exact:

- GNU/Hurd, the  whole systems, is  actually GNU tools  (libc, linker,
  ...)  on top  of the  GNU Hurd  (set of  servers) and  the  GNU Mach
  microkernel.

- GNU Mach 1.x uses drivers from Linux 2.0.36 (IIRC)

- GNU  Mach 2.0  (actually 1.9,  as a  beta version),  uses  the OSKit
  framework, and such drivers from Linux 2.2.12 (but nearly any driver
  for Linux  2.2 can  be easily ported)  or FreeBSD (I  don't remember
  which version, we actually use more Linux drivers).

- In the future, we'll probably use  the L4 microkernel. On top of L4,
  we'll have  to implement user space drivers.   That'ld probably take
  time, so  we may reuse Linux  drivers with glue code  as a temporary
  solution.

- pfinet (our  TCP/IP server)  comes from Linux  2.0 IP stack,  but we
  need a rewrite for that (first  because Linux 2.0 stack's is not the
  best in  the world ;) and  then because kernel-space  code runned in
  user-space with glue code isn't either fast nor flexible).

I'm not aware  of other use of Linux code inside  the Hurd project, or
even inside the GNU project, but there may be.

-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org
