Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269831AbRHIPG5>; Thu, 9 Aug 2001 11:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269832AbRHIPGr>; Thu, 9 Aug 2001 11:06:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269831AbRHIPGd>; Thu, 9 Aug 2001 11:06:33 -0400
Subject: Re: 2.4.4: thread dumping core
To: Ulrich.Windl@rz.uni-regensburg.de (Ulrich Windl)
Date: Thu, 9 Aug 2001 16:08:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B72C08E.3800.1F80245@localhost> from "Ulrich Windl" at Aug 09, 2001 04:55:46 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UrQ3-0007Qq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder whether the kernel does the right thing if a thread causes a 
> segmentation violation: Currently it seems the other LWPs just 
> continue. However in practice this means that the application does not 

This is a feature in most cases

> I suggest to terminate all LWPs if one receives a fatal signal.

So write some signal handlers. 

In all cases the other threads will continue for some time, so you gain
nothing by pretending they dont. 

Alan
