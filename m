Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277473AbRJOL67>; Mon, 15 Oct 2001 07:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277483AbRJOL6u>; Mon, 15 Oct 2001 07:58:50 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:10508 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277434AbRJOL6i>;
	Mon, 15 Oct 2001 07:58:38 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Your message of "Mon, 15 Oct 2001 10:29:39 +0200."
             <Pine.LNX.3.96.1011015101708.22179A-100000@medusa.sparta.lu.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Oct 2001 21:35:09 +1000
Message-ID: <13954.1003145709@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 10:29:39 +0200 (MET DST), 
Bjorn Wesen <bjorn@sparta.lu.se> wrote:
>On Sat, 13 Oct 2001, Keith Owens wrote:
>> ???!  __initcall entries are executed in the order that they are linked
>> into the kernel.  The linkage order is controlled by the order that
>> Makefiles are processed during kbuild and by line order within each
>> Makefile.  There is definitely a priority order for __initcall code.
>
>Not to mention that as an individual sub-project maintainer you can't go
>around changing higher level makefiles all the time just to get your
>particular initcall chain in order (again, in practice).
>
>You could _conceivably_ build an initcall dependency system by adding some
>"initcall_requires" macros which put the dependant other calls into
>another linker table, which the kernel would resolve at boot. 

Absolutely agree.  I would love to separate the initcall order from
directory and Makefile order, using a clean and well documented method
of describing initialisation order.  But there is one massive problem
with changing the existing method, .... Linus likes it this way.

Maybe after kbuild 2.5 is in.  I have learnt to fight one battle at a
time.

