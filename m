Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129389AbRBAJB1>; Thu, 1 Feb 2001 04:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129454AbRBAJBS>; Thu, 1 Feb 2001 04:01:18 -0500
Received: from 13dyn174.delft.casema.net ([212.64.76.174]:34832 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129389AbRBAJBF>; Thu, 1 Feb 2001 04:01:05 -0500
Message-Id: <200102010901.KAA05572@cave.bitwizard.nl>
Subject: Re: Linuxrc runs with PID 7
In-Reply-To: <20010131192338.19211.qmail@web117.yahoomail.com> from Paul Powell
 at "Jan 31, 2001 11:23:38 am"
To: Paul Powell <moloch16@yahoo.com>
Date: Thu, 1 Feb 2001 10:01:03 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Powell wrote:
> This is a followup question to my previous question
> "Why isn't init at PID 1."
> 
> Previoulsy I was calling init from within linuxrc. 
> Linuxrc was a sash script, so the sash script
> supposedly had PID 1.  Now I've removed the script and
> have a C program for linuxrc.
> 
> I'm still not running at PID 1 but at 7.  The linuxrc
> program looks like:
> 
> int main(int argc, char* argv[])
> {
>    printf("PID = %i\n", getpid());
> }
> 
> When I boot and linuxrc is executed, PID equals 7.
> 
> Any ideas as to why this is and how I can run at PID
> 1?

Yes, I've noticed this too. 

I concluded that to the kernel there is something magic about
"init=/bin/someprogram":  The program doesn't get PID 1 anymore. 

I used to have a script there fire up X and then exec init inside an
Xterm. I gave up on this after that junk started happening.

Oh, and Init refuses to be useful if it doesn't end up with PID 1. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
