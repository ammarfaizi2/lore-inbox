Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279589AbRKFPS3>; Tue, 6 Nov 2001 10:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279629AbRKFPST>; Tue, 6 Nov 2001 10:18:19 -0500
Received: from mail.zmailer.org ([194.252.70.162]:39947 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S279598AbRKFPSJ>;
	Tue, 6 Nov 2001 10:18:09 -0500
Date: Tue, 6 Nov 2001 17:17:56 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Yoav Etsion <etsman@cs.huji.ac.il>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HZ value
Message-ID: <20011106171756.K24643@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.20_heb2.08.0111061613410.9426-100000@pomela2.cs.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20_heb2.08.0111061613410.9426-100000@pomela2.cs.huji.ac.il>; from etsman@cs.huji.ac.il on Tue, Nov 06, 2001 at 04:15:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 04:15:25PM +0200, Yoav Etsion wrote:
> Hi,
> 
> Does anyone know why the HZ (asm/param.h) value on the Alpha (1000) is
> different than on any architecture (100)?

	It is 1024.

	Why should it be anything in particular ?

	It being 1024 gives nice properties in certain obscure
	internal time functions.  100 or 1000 can not use same
	tricks as 1024 when a division is needed...

	The 100 is usual UNIX tradition, although other values
	were present in earlier times.   Alpha on the other
	hand has always been a rather fast beast, and there
	a faster timer tick is somewhat justified.

	That 100 is tough for a 386/20MHz, but 1024 is no problem
	for a Pentium-IV/1.5GHz.

> Thanks,
> Yoav Etsion

/Matti Aarnio
