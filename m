Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbTABQnJ>; Thu, 2 Jan 2003 11:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTABQnJ>; Thu, 2 Jan 2003 11:43:09 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:28431 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265114AbTABQnH>; Thu, 2 Jan 2003 11:43:07 -0500
Date: Thu, 2 Jan 2003 16:51:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] more procfs bits for !CONFIG_MMU
Message-ID: <20030102165134.A25983@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030102000522.A6137@lst.de> <Pine.LNX.4.44.0301011539070.12809-100000@home.transmeta.com> <20030101235842.A3044@infradead.org> <20030102162956.GB956@mars.ravnborg.org> <20030102173505.B11900@lst.de> <20030102164914.GC956@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030102164914.GC956@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Jan 02, 2003 at 05:49:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 05:49:14PM +0100, Sam Ravnborg wrote:
> Ups, you are right. I thought about CONFIG_NOMMU..
> Should read:
> proc-y := proc_nommu.o
> proc-$(CONFIG_MMU) := proc_mmu.o
> 
> If CONFIG_MMU is 'y', then the first assignment is overwritten.
> 
> The same principle (pattern?), but with reversed logic.
> But this one is not that nice, because the common case overwrite the
> un-common case.

Yeah.  Maybe we should add obj-no-$(CONFIG_FOO) & friends
