Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286788AbRLVOdn>; Sat, 22 Dec 2001 09:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286789AbRLVOda>; Sat, 22 Dec 2001 09:33:30 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:3336 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286788AbRLVOdK>;
	Sat, 22 Dec 2001 09:33:10 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing 
In-Reply-To: Your message of "Sat, 22 Dec 2001 14:12:45 -0000."
             <E16HmtJ-0004G7-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 01:32:55 +1100
Message-ID: <10295.1009031575@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001 14:12:45 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> User space code should open /proc/dynamic_syscalls, read the lines
>> looking for their syscall name, extract the number and call the glibc
>> syscall() function using that number.  Do not use the _syscalln()
>> functions, they require a constant syscall number at compile time.
>
>Simple brutal and to the point. Also it means a dynamic library can 
>switch to real syscalls and dynamic apps will migrate fine.
>
>One request - can we specify a namespace of the form
>
>['vendorid'].[call]
>
>vendorid is the wrong phrase but "some sane way of knowing whose syscall
>it is" - it would be bad for andrea-aio and ben-aio to use the same names..

Did that in the comments.

/**
 * register_dynamic_syscall - assign a dynamic syscall number.
 * @name: the name of the syscall, used by user space code to find the number.
 *        Use a unique name, if there is any possibility of conflict with
 *        other test syscalls then include your company or initials in the name.


