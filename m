Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265118AbSJWRjz>; Wed, 23 Oct 2002 13:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265119AbSJWRjz>; Wed, 23 Oct 2002 13:39:55 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:27460 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265118AbSJWRjx>; Wed, 23 Oct 2002 13:39:53 -0400
Date: Wed, 23 Oct 2002 10:54:13 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, <lkcd-devel@lists.sourceforge.net>
Subject: Re: [PATCH] LKCD for 2.5.44 (7/8): dump configuration
In-Reply-To: <20021023180134.C16547@infradead.org>
Message-ID: <Pine.LNX.4.44.0210231052430.28800-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because the zlib code option CONFIG_ZLIB_DEFLATE won't be set
to 'n' if the option isn't reset properly.  That means if you
set CONFIG_CRASH_DUMP_COMPRESS_GZIP and then not set it back
explicitly, the CONFIG_ZLIB_DEFLATE option doesn't get set to
'n' properly.

We explored a number of options, but this guarantees that the
zlib code doesn't get built if it doesn't have to.

--Matt

On Wed, 23 Oct 2002, Christoph Hellwig wrote:
|>On Wed, Oct 23, 2002 at 02:44:55AM -0700, Matt D. Robinson wrote:
|>> +else
|>> +   define_tristate CONFIG_CRASH_DUMP_BLOCKDEV n
|>> +   define_tristate CONFIG_CRASH_DUMP_COMPRESS_RLE n
|>> +   define_tristate CONFIG_CRASH_DUMP_COMPRESS_GZIP n
|>
|>What's the reason for this?
|>

-- 

