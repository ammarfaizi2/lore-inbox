Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286340AbRLJSRs>; Mon, 10 Dec 2001 13:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286341AbRLJSRj>; Mon, 10 Dec 2001 13:17:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60426 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286340AbRLJSRc>; Mon, 10 Dec 2001 13:17:32 -0500
Subject: Re: mm question
To: volodya@mindspring.com
Date: Mon, 10 Dec 2001 18:26:35 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0112101307360.18115-100000@node2.localnet.net> from "volodya@mindspring.com" at Dec 10, 2001 01:08:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DV8N-0002vK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This makes it rather hard to go around trying to free pages
> > within a certain physical range.
> 
> Well, what does kernel do when it runs out of memory ? For example when I
> mmap a large file and start reading it back and force ?

It doesn't care which physical page it gets. Processes being freeing
up/swapping pages they have mappings to. The map counts hit zero and the 
page is discarded.

Alan
