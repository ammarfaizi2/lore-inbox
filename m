Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319187AbSHMXip>; Tue, 13 Aug 2002 19:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319184AbSHMXhf>; Tue, 13 Aug 2002 19:37:35 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41469 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319181AbSHMXgb>; Tue, 13 Aug 2002 19:36:31 -0400
Subject: Re: Cache coherency and snooping
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: imran.badr@cavium.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0a9a01c24320$4c936de0$9e10a8c0@IMRANPC>
References: <0a9a01c24320$4c936de0$9e10a8c0@IMRANPC>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Aug 2002 00:38:08 +0100
Message-Id: <1029281888.21007.157.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 00:22, Imran Badr wrote:
> How can I define a certain region of memory so that it is never cached? I
> want to use non-cached region of memory to communicate to my PCI device to
> avoid system overhead in cache snooping.

Architecture specific and for RAM quite often not supported at all. You
can use ioremap_nocache on ram in theory but that doesn't actually work
on most processors, will MCE on the PPro and needs some work on Athlon
XP/MP

K6/K5 don't support it at all from memory.

If your hardware is sane it will already be doing cache line size bursts
and MWI.

