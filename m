Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130502AbRCIMsJ>; Fri, 9 Mar 2001 07:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRCIMr7>; Fri, 9 Mar 2001 07:47:59 -0500
Received: from 13dyn199.delft.casema.net ([212.64.76.199]:24326 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130502AbRCIMrv>; Fri, 9 Mar 2001 07:47:51 -0500
Message-Id: <200103091247.NAA31936@cave.bitwizard.nl>
Subject: Re: Microsoft begining to open source Windows 2000?
In-Reply-To: <01030906084600.09523@tabby> from Jesse Pollard at "Mar 9, 2001
 06:05:20 am"
To: Jesse Pollard <jesse@cats-chateau.net>
Date: Fri, 9 Mar 2001 13:47:19 +0100 (MET)
CC: Graham Murray <graham@webwayone.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> On Fri, 09 Mar 2001, Graham Murray wrote:
> >"Mohammad A. Haque" <mhaque@haque.net> writes:
> >
> >> making a patch means you've modfied the source which you are not allowed
> >> to do. The most you can do is report the bug through normal channels
> >> (you dont even have priority in reporting bugs since you have the code).
> >
> >Does making a patch necessarily require modifying the source code?
> >Back in my days as a mainframe systems programmer (ICL VME/B), most OS
> >patches were made to the binary image, either in the file or to the
> >loaded virtual memory image.

> Nearly always. The problem is that the patch may make the module
> bigger/smaller or relocate variables whose address then changes. All
> locations that these are referenced must be modified (either direct
> address or offset).  Sometimes other modules will get relocated too.

You're too young. Or I'm too old. :-)

IF your patch can be inserted into the code space available: Then good. 
If not, you move the code out of the previously allocated space, and
put it somewhere else. Put a "jump" instruction in the old place. 


At the university there was a lab-assignment where we had to use the
provided semaphore routines. Turns out we found a bug. The TA then
told us it was going to be hard-to-fix, as about 8192 bytes of the 8k
PROM were in use. He was wrong. The bug was one instruction too
many. We just wrote "nop" over the bad instruction. The processor had
also been correctly designed: you could overwrite any instruction in
the PROM with "nop", as the NOP instruction was 0xff. Fixed on the
spot!

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
