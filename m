Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281004AbRLWKxn>; Sun, 23 Dec 2001 05:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286863AbRLWKxX>; Sun, 23 Dec 2001 05:53:23 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:32720 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S281004AbRLWKxM>;
	Sun, 23 Dec 2001 05:53:12 -0500
Date: Sun, 23 Dec 2001 10:53:03 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: How to fix false positives on references to discarded
 text/data?
Message-ID: <940624132.1009104782@[195.224.237.69]>
In-Reply-To: <23259.1009099071@ocs3.intra.ocs.com.au>
In-Reply-To: <23259.1009099071@ocs3.intra.ocs.com.au>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, 23 December, 2001 8:17 PM +1100 Keith Owens <kaos@ocs.com.au> 
wrote:

> (5) Post process the objects before ld sees them, remove the dangling
>     references in safe sections.
>
>     Will probably mess up timestamps on objects, as well as requiring
>     yet another program for kernel build.  Cross compiling would be
>     "interesting".
>

1+5) (seeing as you seem to have already written some perl); would it
     be possible to run our own perl code to check for whichever dangling
     references we are concerned about (and not those we aren't), then do

> (1) Drop the ld check for discarded sections.
>
>     I don't want to lose the ld check, it has already found several
>     bits of buggy code.  For example, usb_uhci.c calls the exit routine
>     from the init code on error, but the exit code has been discarded
>     in vmlinux - oops.  New binutils flagged that bug and others.

This would seem to have the advantage of better readability of errors
too.

--
Alex Bligh
