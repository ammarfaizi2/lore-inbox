Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSHKSY7>; Sun, 11 Aug 2002 14:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSHKSY7>; Sun, 11 Aug 2002 14:24:59 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:11252 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317799AbSHKSY6>; Sun, 11 Aug 2002 14:24:58 -0400
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D56147E.15E7A98@zip.com.au>
References: <3D56147E.15E7A98@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Aug 2002 20:49:56 +0100
Message-Id: <1029095396.16216.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-11 at 08:38, Andrew Morton wrote:
> This information loss is unfortunate.  Examples:
> 
> 	for (i = 0; i < N; i++)
> 		prefetch(foo[i]);
> 
>    Problem is, if `prefetch' is a no-op, the compiler will still
>    generate an empty busy-wait loop.  Which it must do. 

Why - nothing there is volatile


