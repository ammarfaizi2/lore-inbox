Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSGLONl>; Fri, 12 Jul 2002 10:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSGLONk>; Fri, 12 Jul 2002 10:13:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54276 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316519AbSGLONj>; Fri, 12 Jul 2002 10:13:39 -0400
Subject: Re: Advice saught on math functions
To: kirk@braille.uwo.ca (Kirk Reiser)
Date: Fri, 12 Jul 2002 15:39:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E17T15g-0007mP-00@speech.braille.uwo.ca> from "Kirk Reiser" at Jul 12, 2002 10:08:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T1a9-00037I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are these functions which are supplied by the FPU?  I've looked
> through the fpu emulation headers and exp() is the only one I can find

You can't use FPU operations in the x86 kernel.

Maybe you should do this in user space ? Certainly the more I talk to people
like Nicholas Pitre the more it seems to me that most of the kernel side
stuff is the wrong approach.

Instead would it not be better to

-	Fix select on /dev/vcsa to work
-	During init start up after init processes are running have
	the init tasks (or for that matter the kernel) fire up the
	speech helper

The fact 95% of the speakup drivers are going to spontaneously go 
obsolete the moment serial ports vanish bothers me.
