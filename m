Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277792AbRJIPuj>; Tue, 9 Oct 2001 11:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277790AbRJIPuT>; Tue, 9 Oct 2001 11:50:19 -0400
Received: from sushi.toad.net ([162.33.130.105]:1721 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277788AbRJIPuM>;
	Tue, 9 Oct 2001 11:50:12 -0400
Subject: Re: sysctl interface to bootflags?
From: Thomas Hood <jdthood@mail.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110091731480.31520-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.30.0110091731480.31520-100000@Appserv.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 11:50:08 -0400
Message-Id: <1002642610.1103.39.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I didn't read your code very carefully before because
I thought it relied on ACPI.  Now I understand it better.
It doesn't use /dev/nvram, but /dev/mem.

Here's what happens when I run it.

jdthood@thanatos:~/src/sbf$ gcc sbf.c
jdthood@thanatos:~/src/sbf$ su
Password: 
root@thanatos:/home/jdthood/src/sbf# gdb -q ./a.out
(no debugging symbols found)...(gdb) run
Starting program: /mnt/p/home/jdthood/src/sbf/./a.out 
BOOT @ 0x07fd0040
CMOS register:51
(no debugging symbols found)...(no debugging symbols found)...
Program received signal SIGSEGV, Segmentation fault.
0x80489be in outb_p ()

--
Thomas

On Tue, 2001-10-09 at 11:34, Dave Jones wrote:
> On 9 Oct 2001, Thomas Hood wrote:
> 
> > Hi.  I looked at your code and I saw that it depended
> > on ACPI.  Since ACPI doesn't work on my machine, I
> > thought I should look for another solution.  However,
> 
> Huh ? Read the code again.
> Its no more dependant upon ACPI than bootflag.c is.
> The bootflag is pointed at by an ACPI table.
> The code I wrote functions /exactly/ the same on
> a kernel with APM, ACPI or NO power management.
> 
> > Alan now tells me that what I want to do can already
> > be done via /dev/nvram.
> 
> My code _is_ using /dev/nvram !
> 
> regards,
> 
> Dave.
> 
> -- 
> | Dave Jones.        http://www.suse.de/~davej
> | SuSE Labs
> 


