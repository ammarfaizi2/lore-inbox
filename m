Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTFMJoa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 05:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTFMJoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 05:44:30 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:20484 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261265AbTFMJoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 05:44:30 -0400
Date: Fri, 13 Jun 2003 19:57:59 +1000
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
Message-ID: <20030613095759.GA15003@gondor.apana.org.au>
References: <1052513725.15923.45.camel@andyp.pdx.osdl.net> <1055369326.1158.252.camel@andyp.pdx.osdl.net> <1055373692.16483.8.camel@chtephan.cs.pocnet.net> <1055377253.1222.8.camel@andyp.pdx.osdl.net> <20030611172958.5e4d3500.akpm@digeo.com> <1055438856.1202.6.camel@andyp.pdx.osdl.net> <20030612105347.6ea644b7.akpm@digeo.com> <1055441028.1202.11.camel@andyp.pdx.osdl.net> <1055442331.1225.11.camel@andyp.pdx.osdl.net> <20030613010149.359cb4dd.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613010149.359cb4dd.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 01:01:49AM -0700, Andrew Morton wrote:
> 
> Fix this by just leaving the inode dirty and moving on to inspect the other
> blockdev inodes on sb->s_io.

This fixes it for me.  Thanks Andrew.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
