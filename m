Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRDBTzq>; Mon, 2 Apr 2001 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRDBTzg>; Mon, 2 Apr 2001 15:55:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43024 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131276AbRDBTzc>; Mon, 2 Apr 2001 15:55:32 -0400
Subject: Re: Linux 2.4.2-ac27
To: home@mdiehl.de (Martin Diehl)
Date: Mon, 2 Apr 2001 20:56:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
   torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103290059580.7191-100000@notebook.diehl.home> from "Martin Diehl" at Mar 29, 2001 10:04:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kAR9-0006c6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is consistent throughout all 2.4.x at least. From your comment I've
> learnt SuS v2 requires -ENODEV for the len=0 case. While this would

it needs -ENODEV for all cases where you mmap a file which does not support
mmap operations. A 0 length mmap could return the address, EINVAL and maybe
some other stuff. 

