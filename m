Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbSKNDxr>; Wed, 13 Nov 2002 22:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSKNDxr>; Wed, 13 Nov 2002 22:53:47 -0500
Received: from rth.ninka.net ([216.101.162.244]:63120 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S263135AbSKNDxq>;
	Wed, 13 Nov 2002 22:53:46 -0500
Subject: Re: bk current build failures (xfrm.h / tpqic02.c)
From: "David S. Miller" <davem@redhat.com>
To: Kevin Brosius <cobra@compuserve.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD2F0FF.D1306F88@compuserve.com>
References: <3DD2F0FF.D1306F88@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 20:17:37 -0800
Message-Id: <1037247457.10978.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 16:40, Kevin Brosius wrote:
> net/core/skbuff.c: At top level:
> include/net/xfrm.h:104: storage size of `lft' isn't known
> include/net/xfrm.h:112: storage size of `replay' isn't known
> include/net/xfrm.h:115: storage size of `stats' isn't known
> include/net/xfrm.h:117: storage size of `curlft' isn't known
> make[2]: *** [net/core/skbuff.o] Error 1

Something is wrong with your tree, net/xfrm.h includes linux/xfrm.h
which declares the layout of said structures the compiler is
complaining about.

