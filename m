Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262974AbTCWIfT>; Sun, 23 Mar 2003 03:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbTCWIfS>; Sun, 23 Mar 2003 03:35:18 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:21260 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262974AbTCWIfS>; Sun, 23 Mar 2003 03:35:18 -0500
Date: Sun, 23 Mar 2003 08:46:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] alternative dev patch
Message-ID: <20030323084621.A6788@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org, akpm@digeo.com
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303202314210.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0303202314210.5042-100000@serv>; from zippel@linux-m68k.org on Fri, Mar 21, 2003 at 12:03:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 12:03:57AM +0100, Roman Zippel wrote:
> char devices don't have partitions, so you hardly need regions. The 
> problem with the tty layer is that the console and the serial devices 
> should have different majors.

That;s not exactly true.  A tradition major device is nothing but a
region with a fixed size, and we need to get rid of this major/minor
thinking.  Converting a dev_t to struct char_device * / struct block_device *
early is the way we wan't to go for that.  It helped the block layer
a lot..

