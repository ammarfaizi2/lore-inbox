Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318741AbSHLQmr>; Mon, 12 Aug 2002 12:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318746AbSHLQmr>; Mon, 12 Aug 2002 12:42:47 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:21510 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318741AbSHLQmr>; Mon, 12 Aug 2002 12:42:47 -0400
Date: Mon, 12 Aug 2002 17:46:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Phil Auld <pauld@egenera.com>
Cc: viro@math.psu.edu, marcelo@connectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19 revert block_llseek behavior to standard
Message-ID: <20020812174634.A10106@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Phil Auld <pauld@egenera.com>, viro@math.psu.edu,
	marcelo@connectiva.com.br, linux-kernel@vger.kernel.org
References: <20020812120659.B27650@vienna.EGENERA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020812120659.B27650@vienna.EGENERA.COM>; from pauld@egenera.com on Mon, Aug 12, 2002 at 12:06:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 12:06:59PM -0400, Phil Auld wrote:
> Hi Al,
> 	I think this falls under the VFS umbrella, but I may be wrong. 
> 
> Below is a fix to make block_llseek behave as specified in the Single Unix Spec. v3.
> (http://www.unix-systems.org/single_unix_specification/). It's extremely trivial but
> may have political baggage.

Have you tested when you actually seek over the size of a block device?
Stupid standards aside: what is the purpose of this?  blockdevices won't
grow bigger if you seek beyond them..

Did any Linux implementation ever follow the standard (as you rewrite
reverse)?  What's the behaviour of other unix systems when seeking
beyond the end of block devices?
