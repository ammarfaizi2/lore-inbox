Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbTBLV5j>; Wed, 12 Feb 2003 16:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267877AbTBLV5j>; Wed, 12 Feb 2003 16:57:39 -0500
Received: from tapu.f00f.org ([202.49.232.129]:59582 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267812AbTBLV5h>;
	Wed, 12 Feb 2003 16:57:37 -0500
Date: Wed, 12 Feb 2003 14:07:27 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT foolish question
Message-ID: <20030212220727.GB12819@f00f.org>
References: <1045084764.4767.76.camel@urca.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045084764.4767.76.camel@urca.rutgers.edu>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 04:19:24PM -0500, Bruno Diniz de Paula wrote:

> I am trying to use O_DIRECT to read ordinary files and read syscall
> always returns 0, unless when the file size equals the fs block
> size.

Sounds correct.

> Is it true that I can only use O_DIRECT when the size of the file
> written in the inode is a multiple of block size?

You usually can only do O_DIRECT reads/writes in multiples of the
block size (or in some cases multiples of 512-bytes, but I'm not sure
of that code is still about though).

It depends on the filesystem to some extent.


  --cw
