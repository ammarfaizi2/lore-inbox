Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264230AbTCXOxx>; Mon, 24 Mar 2003 09:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264234AbTCXOxx>; Mon, 24 Mar 2003 09:53:53 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:8452 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264230AbTCXOxw>; Mon, 24 Mar 2003 09:53:52 -0500
Date: Mon, 24 Mar 2003 15:04:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
Message-ID: <20030324150458.A19789@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries Brouwer <aebr@win.tue.nl>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
References: <Pine.LNX.4.44.0303240023420.9053-100000@serv> <20030324142515.GA10462@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030324142515.GA10462@win.tue.nl>; from aebr@win.tue.nl on Mon, Mar 24, 2003 at 03:25:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 03:25:15PM +0100, Andries Brouwer wrote:
> It still looks like you do not understand the purpose of these patches.
> First of all, it is a series - code is morphed into a more desirable
> state; at each point in time there are imperfections, and some of these
> disappear the next stage.
> The first goal is not at all handling many devices. The first goal is
> having a larger dev_t. Handling many devices comes after that.

Well, there's people here who disagree with tour order.  And yes, making
dev_t larger before making the kernel ready for a large number of devices
is the wrong way around.

If you look at Roman's patches they don't even hinder your dev_t enlargement
but they provide a singificant benefit.   Now I'm personally not yet
completly happy with his interface either because he still uses the
major/minor split, but I'm working on fixing this properly.
