Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314505AbSEFPWF>; Mon, 6 May 2002 11:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSEFPWE>; Mon, 6 May 2002 11:22:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30483 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314525AbSEFPUd>; Mon, 6 May 2002 11:20:33 -0400
Subject: Re: modversion.h improvement suggestion
To: sebastian-huber@web.de (Sebastian Huber)
Date: Mon, 6 May 2002 16:39:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E174OQu-0007H2-00@smtp.web.de> from "Sebastian Huber" at May 05, 2002 06:00:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E174kaX-0005Xb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried to compile a device driver module and got the error that 
> 'modversion.h' cannot be found. My first questions were:

A device driver should not be directly including modversions.h. Its 
included automatically by the kernel build line only in the case where
CONFIG_MODVERSIONS is set.

If the module is being built seperate to the tree then it should probably
borrow the Make rules the kernel uses
