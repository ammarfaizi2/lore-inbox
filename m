Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262005AbTCLWI4>; Wed, 12 Mar 2003 17:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbTCLWI4>; Wed, 12 Mar 2003 17:08:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36296
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262005AbTCLWIy>; Wed, 12 Mar 2003 17:08:54 -0500
Subject: Re: [PATCH] bug in 2.4 bh_kmap_irq() breaks IDE under preempt patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joe Korty <joe.korty@ccur.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303122213.WAA17415@rudolph.ccur.com>
References: <200303122213.WAA17415@rudolph.ccur.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047511647.23902.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 23:27:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 22:13, Joe Korty wrote:
> The bug is that bh_map_irq *conditionally* calls kmap_atomic (which
> disables preemption as one of its functions), while bh_unmap_irq
> *unconditionally* calls kunmap_atomic (which enables it).  This

Thats a pre-empt bug ont a bh_map_irq bug. I'm glad you've found it
however. It explains a few things and will be useful for people wanting
pre-empt 2.4 .


