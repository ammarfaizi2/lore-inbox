Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319004AbSIDB4O>; Tue, 3 Sep 2002 21:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319005AbSIDB4O>; Tue, 3 Sep 2002 21:56:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23513 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319004AbSIDB4N>;
	Tue, 3 Sep 2002 21:56:13 -0400
Date: Tue, 03 Sep 2002 18:54:01 -0700 (PDT)
Message-Id: <20020903.185401.92386108.davem@redhat.com>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <al3m2p$lnp$1@cesium.transmeta.com>
References: <200209021858.WAA00388@sex.inr.ac.ru>
	<20020903.164243.21934772.taka@valinux.co.jp>
	<al3m2p$lnp$1@cesium.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "H. Peter Anvin" <hpa@zytor.com>
   Date: 3 Sep 2002 18:02:17 -0700

   Followup to:  <20020903.164243.21934772.taka@valinux.co.jp>
   By author:    Hirokazu Takahashi <taka@valinux.co.jp>
   In newsgroup: linux.dev.kernel
   > 
   > P.S.
   >     Using "bswap" is little bit tricky.
   > 
   
   It needs to be protected by CONFIG_I486 and alternate code implemented
   for i386 (xchg %al,%ah; rol $16,%eax, xchg %al,%ah for example.)
   
He only used bswap in the P-II/PPRO csum_partial, which is
ifdef protected.
