Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263818AbTCUUrC>; Fri, 21 Mar 2003 15:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263819AbTCUSxl>; Fri, 21 Mar 2003 13:53:41 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:23046 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263816AbTCUSxU>; Fri, 21 Mar 2003 13:53:20 -0500
Date: Fri, 21 Mar 2003 19:04:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: Update ide/legacy makefile to match changes
Message-ID: <20030321190420.A7831@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <200303211929.h2LJTfnV025808@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303211929.h2LJTfnV025808@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 21, 2003 at 07:29:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 07:29:41PM +0000, Alan Cox wrote:
>  # Last of all
> +ifneq ($(CONFIG_X86_PC9800),y)
>  obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
> +else
> +obj-$(CONFIG_BLK_DEV_HD)		+= hd98.o
> +endif

That stupid.  hd98.o should habe it's own config option instead
of overloading CONFIG_BLK_DEV_HD (CONFIG_BLK_DEV_HD98?).

