Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272110AbRIELqr>; Wed, 5 Sep 2001 07:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272109AbRIELqi>; Wed, 5 Sep 2001 07:46:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21508 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272102AbRIELqd>; Wed, 5 Sep 2001 07:46:33 -0400
Subject: Re: reliable debug output
To: cwidmer@iiic.ethz.ch
Date: Wed, 5 Sep 2001 12:50:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109051055.f85AtGe15458@mail.swissonline.ch> from "Christian Widmer" at Sep 05, 2001 12:55:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ebCR-0005eF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when debugging drivers using printk i've the problem that most often 
> the msg passed to printk don't show up on the console since the machine 
> crashed before. i also what to use my own ASSERT macros which halt the 

printk writes to the console synchronously unless you have configured
syslogk to process the messages and log them itself. You may want to boot
with syslogk disabled and see if that is your problem.

2.4 also supports serial console which can be useful when the box insists on
crashing in X11
