Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSKSANU>; Mon, 18 Nov 2002 19:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSKSANU>; Mon, 18 Nov 2002 19:13:20 -0500
Received: from ns.suse.de ([213.95.15.193]:28178 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265247AbSKSANT>;
	Mon, 18 Nov 2002 19:13:19 -0500
Date: Tue, 19 Nov 2002 01:20:21 +0100
From: Andi Kleen <ak@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: ak@suse.de, gzp@myhost.mynet, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] fix devfs compile problems was Re: Linux v2.5.48
Message-ID: <20021119012021.A21171@wotan.suse.de>
References: <200211190007.QAA00499@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211190007.QAA00499@baldur.yggdrasil.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 04:07:17PM -0800, Adam J. Richter wrote:
> Hi Linus,
> 
> 	I'd like to recommend that you apply this to fix
> fs/devfs/base.c compilation problems instead of Andi's patch, as this
> one ensures that {a,m,c}time will all have the same value even if
> successive calls to get_seconds() might someday be able to return
> different values.  Do you concur, Andi?

If you want to make it 100% correct change the de->inode.[mac]time to
struct timespec. If you just want it working the first patch is probably
fine.

-Andi
