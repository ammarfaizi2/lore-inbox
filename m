Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276204AbRJGJkp>; Sun, 7 Oct 2001 05:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276244AbRJGJkf>; Sun, 7 Oct 2001 05:40:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13316 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276204AbRJGJkT>; Sun, 7 Oct 2001 05:40:19 -0400
Subject: Re: %u-order allocation failed
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Date: Sun, 7 Oct 2001 10:40:23 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel),
        kszysiu@main.braxis.co.uk (Krzysztof Rusocki), linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1011006164044.29342B-200000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Oct 06, 2001 04:44:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qAQ3-0005Eq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here goes the fix. (note that I didn't try to compile it so there may be
> bugs, but you see the point). 

It isnt a fix

> kmalloc should be fixed too (used badly for example in select.c - and yes
> - I have seen real world bugreports for poll randomly failing with
> ENOMEM), but it will be hard to audit all drivers that they do not try to
> use dma on kmallocated memory. 

So you run out of blocks of vmalloc address space instead. The same problem
still occurs and always will
