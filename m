Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUHJTvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUHJTvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267682AbUHJTvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:51:36 -0400
Received: from hera.kernel.org ([63.209.29.2]:43936 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267685AbUHJTvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:51:35 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: AES assembler optimizations
Date: Tue, 10 Aug 2004 19:51:29 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cfb901$ctg$1@terminus.zytor.com>
References: <2riR3-7U5-3@gated-at.bofh.it> <m3d620v11e.fsf@averell.firstfloor.org> <1092067328.4332.40.camel@orion> <20040809171231.GG2716@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1092167489 13233 127.0.0.1 (10 Aug 2004 19:51:29 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 10 Aug 2004 19:51:29 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040809171231.GG2716@mea-ext.zmailer.org>
By author:    Matti Aarnio <matti.aarnio@zmailer.org>
In newsgroup: linux.dev.kernel
> 
> Usage of MMX inside the Linux kernel is like the usage of FP inside
> the Linux kernel:  Can be done after jumping complex hoops, BUT NOT
> RECOMMENDED... (MMX in intertwined with FP hardware, after all.)
> 
> You have to do lots of the MMXes in order to win after amortizing those
> necessary hoops...  RAID-5 code does XOR via MMX code, under some 
> conditions.  ... where that happens to become a win.
> 

It's not really that hard, you just have to have enough work to
amortize it over.  The two metrics are: how much work do you get per
call, and how much work do you get before the next schedule().

	-hpa
