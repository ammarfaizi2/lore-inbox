Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265043AbRGAHW6>; Sun, 1 Jul 2001 03:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265044AbRGAHWi>; Sun, 1 Jul 2001 03:22:38 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:61636 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S265043AbRGAHWa>; Sun, 1 Jul 2001 03:22:30 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200107010722.IAA29492@mauve.demon.co.uk>
Subject: Re: Cosmetic JFFS patch.
To: linux-kernel@vger.kernel.org
Date: Sun, 1 Jul 2001 08:22:04 +0100 (BST)
In-Reply-To: <200107010632.CAA26426@razor.cs.columbia.edu> from "Hua Zhong" at Jul 01, 2001 02:32:46 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Is this (printing out versions. etc) really a big deal so we should add stuff 
> like "/proc/xxx", KERN_XXXX to make things more complicated?  It sounds to me 
> like to make the kernel "smaller" we'd actually end up with adding more code 
> and complexity to it.  And quite frankly, if people don't read MAINTAINERS, 
> they won't read /proc/maintainers either.

That was why I had the thought of doing it at compile time, based on a
magic list of versions only updated by Linus.
As I've been told that this won't work very well due to some people having
the temerity to disagree with him on driver versions shipped :), something
more flexible is needed.

I can't think of a neat way to do this, without knowing the source
tree the kernel came from though.
I think at least knowing what drivers are not stock might be useful.

Perhaps 
make distversion xxx
would add another string to KERNELRELEASE, setting a major releases "stock"
drivers, and letting anything that changes thereafter have a higher
default display level.

