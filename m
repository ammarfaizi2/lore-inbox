Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136036AbREGNxQ>; Mon, 7 May 2001 09:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136058AbREGNxF>; Mon, 7 May 2001 09:53:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53256 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136036AbREGNwy>; Mon, 7 May 2001 09:52:54 -0400
Subject: Re: [Question] Explanation of zero-copy networking
To: alexander.eichhorn@rz.tu-ilmenau.de
Date: Mon, 7 May 2001 14:56:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AF6A697.22370520@rz.tu-ilmenau.de> from "Alexander Eichhorn" at May 07, 2001 03:43:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wlUi-0003WQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> documented so far) detailed description of the newly 
> implemented zero-copy mechanisms in the network-stack. 
> We are interested in how to use it (changed network-API?) 
> and also in the internal architecture. 

It is built around sendfile. Trying to do zero copy on pages with user space
mappings get so horribly non pretty it is better to build the API from the
physical side of things.

> Our second question: Are there any plans for contructing 
> a general copy-avoidance infrastructure (smth. like UVM in 
> NetBSD does) and new IPC-mechanisms on top of it yet??

Andrea Arcangeli has O_DIRECT file I/O for the ext2 file system. There are also
several patches for kiovec based single copy pipes have been posted too.


