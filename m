Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287765AbSAAGqA>; Tue, 1 Jan 2002 01:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287767AbSAAGpu>; Tue, 1 Jan 2002 01:45:50 -0500
Received: from femail43.sdc1.sfba.home.com ([24.254.60.37]:38826 "EHLO
	femail43.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287765AbSAAGpc>; Tue, 1 Jan 2002 01:45:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: samson swanson <intellectcrew@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: prog for no OS. language?
Date: Mon, 31 Dec 2001 17:43:48 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011231075235.66176.qmail@web14309.mail.yahoo.com>
In-Reply-To: <20011231075235.66176.qmail@web14309.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020101064531.GXBC23819.femail43.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 December 2001 02:52 am, samson swanson wrote:
> hello,
>
> I had a quick question. Say I want to write a program
> to run without an OS, what language/tools do i need?

The first thing you have to write is a boot sector.  On Intel, this will be 
written in 16 bit assembler.

> linus (if you read this) what language/means did you
> use to make your terminal emulation program before
> linux?

Linus wrote a book, you know.  "Just for fun".  Amazon should have it...

Or, if you don't have the patience, you could read this:

http://www.li.org/linuxhistory.php

Basically, if you're writing code without ANY OS behind it, you'll be doing 
it in assembler, and in order to use 32 bit assembler, you first have to set 
up the page tables and interrupt handlers (and know what the A20 line is for, 
although you do NOT have to know why the heck it seems to live on the 
keyboard controller...), set up your own scheduler (or pretty much disable 
interrupts), and basically re-implement a small operating system in order to 
get to the point where you can write in some other language (like C).

Linus did it because he was bored, and a college student.  It took him 3 
months (summer off from school).  Why write a term program you boot into?  
Becaue he was using minix as his os, and minix sucks at handling interrupts.  
You try doing serial IO (to talk to the school's unix box through a modem) 
when your serial port drops characters left and right.  (I don't think he 
even had a 16550a uart at the time... :)

To see what's involved when Linux boots up, read 
http://www.moses.uklinux.net/patches/lki.html

You could also go look at the freedos project...

Just getting to 32 bit mode is a bit of an accomplishment, actually.  Booting 
modern intel hardware recapitulates phylogeny...

Rob
