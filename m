Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbTCWPAQ>; Sun, 23 Mar 2003 10:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbTCWPAQ>; Sun, 23 Mar 2003 10:00:16 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:64272 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263079AbTCWPAP>; Sun, 23 Mar 2003 10:00:15 -0500
Date: Sun, 23 Mar 2003 16:11:16 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Christoph Hellwig <hch@infradead.org>
cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>, <akpm@digeo.com>
Subject: Re: [PATCH] alternative dev patch
In-Reply-To: <20030323084621.A6788@infradead.org>
Message-ID: <Pine.LNX.4.44.0303231605470.5042-100000@serv>
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl>
 <Pine.LNX.4.44.0303202314210.5042-100000@serv> <20030323084621.A6788@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 23 Mar 2003, Christoph Hellwig wrote:

> That;s not exactly true.  A tradition major device is nothing but a
> region with a fixed size, and we need to get rid of this major/minor
> thinking.  Converting a dev_t to struct char_device * / struct block_device *
> early is the way we wan't to go for that.  It helped the block layer
> a lot..

I basically agree, I only want to note that the block layer only has to 
deal with disks, where we have different types of character devices. So 
having one major per serial/tape/tty/... devices might not be necessary, 
but it could makes things bit easier. In any case the actual drivers 
should not see any of this.

bye, Roman

