Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSHVP6i>; Thu, 22 Aug 2002 11:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHVP6i>; Thu, 22 Aug 2002 11:58:38 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:49843 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S313558AbSHVP6h>; Thu, 22 Aug 2002 11:58:37 -0400
Subject: Re: MM patches against 2.5.31
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
In-Reply-To: <3D644C70.6D100EA5@zip.com.au>
References: <3D644C70.6D100EA5@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 22 Aug 2002 09:59:17 -0600
Message-Id: <1030031958.14756.479.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 20:29, Andrew Morton wrote:
> I've uploaded a rollup of pending fixes and feature work
> against 2.5.31 to
> 
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/2.5.31-mm1/
> 
> The rolled up patch there is suitable for ongoing testing and
> development.  The individual patches are in the broken-out/
> directory and should all be documented.

The good news:  I ran my dbench 1..128 stress test and for the first
time since 2.5.31-vanilla there were _no_ BUG()s reported at all.

The other news:  from dmesg:
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald: page allocation failure. order:0, mode:0x0

The kjournald failure message came out with dbench 48 running on an ext3
partition.  The test continued with only this one instance of this
message.

Steven

