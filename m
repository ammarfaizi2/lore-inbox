Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbRGZHyx>; Thu, 26 Jul 2001 03:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267681AbRGZHyo>; Thu, 26 Jul 2001 03:54:44 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:24587 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S267672AbRGZHyg>;
	Thu, 26 Jul 2001 03:54:36 -0400
Date: Thu, 26 Jul 2001 09:54:40 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Andrew McNamara <andrewm@connect.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to tell Linux *not* to share IRQs ?
Message-ID: <20010726095440.A27365@se1.cogenit.fr>
In-Reply-To: <E15PYDE-0002tj-00@the-village.bc.nu> <20010726070621.D69A1BE91@wawura.off.connect.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010726070621.D69A1BE91@wawura.off.connect.com.au>; from andrewm@connect.com.au on Thu, Jul 26, 2001 at 05:06:21PM +1000
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andrew McNamara <andrewm@connect.com.au> ecrit :
[...]
> Does this mean the ISRs for every driver sharing an interrupt have to
> poll their device when an interrupt comes in (in the case of shared PCI

The ISR must verify there is some pending work for him.
Thus one must poll the device or his interrupt status queue in memory if 
any. Btw one may end doing the work before the real interrupt comes.

-- 
Ueimor
