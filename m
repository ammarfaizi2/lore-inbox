Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264693AbSJ3Oya>; Wed, 30 Oct 2002 09:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264694AbSJ3Oya>; Wed, 30 Oct 2002 09:54:30 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:63874 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264693AbSJ3Oy3>; Wed, 30 Oct 2002 09:54:29 -0500
Subject: Re: prevent swsusp from eating disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210291637440.1205-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0210291637440.1205-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Oct 2002 15:20:24 +0000
Message-Id: <1035991224.5141.70.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why aren't those fields initialized explicitly in the static declaration
> of idedisk_driver? And what are the do_idedisk_suspend/do_idedisk_resume
> functions, that _are_ initialized explicitly?
> 
> I want to understand the madness, not add to it.

The IDE devices are already beginning to use the pci suspend/resume
callbacks so I would prefer that we have a very clear model of WTF is
going on here.

