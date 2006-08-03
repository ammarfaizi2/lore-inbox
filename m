Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWHCRhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWHCRhI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWHCRhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:37:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52355 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964824AbWHCRhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:37:07 -0400
Subject: Re: [PATCH 2.4.32] Fix AVM C4 ISDN card init problems with newer
	CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jukka Partanen <jspartanen@gmail.com>
Cc: kkeil@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com>
References: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 18:56:15 +0100
Message-Id: <1154627776.23655.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 19:53 +0300, ysgrifennodd Jukka Partanen:
> AVM C4 ISDN NIC: Add three memory barriers, taken from 2.6.7,
> (they are there in 2.6.17.7 too), to fix module initialization
> problems appearing with at least some newer Celerons and
> Pentium III.

Should be using cpu_relax() I think. Its a polled busy loop so you want
other CPU threads to run if possible. Otherwise the code seems quite
logical depending how c4inmeml is defined.

Alan

