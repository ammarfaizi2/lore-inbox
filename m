Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRKSIqj>; Mon, 19 Nov 2001 03:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKSIq3>; Mon, 19 Nov 2001 03:46:29 -0500
Received: from t2.redhat.com ([199.183.24.243]:9462 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S274875AbRKSIqP>; Mon, 19 Nov 2001 03:46:15 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011118202252.A8708@vger.timpanogas.org> 
In-Reply-To: <20011118202252.A8708@vger.timpanogas.org>  <200111181710.fAIHAlCF011794@sleipnir.valparaiso.cl> <Pine.LNX.4.33.0111181803040.7482-100000@penguin.transmeta.com> 
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Andrea Arcangeli <andrea@suse.de>, ehrhardt@mathematik.uni-ulm.de,
        linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Nov 2001 08:44:28 +0000
Message-ID: <588.1006159468@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jmerkey@vger.timpanogas.org said:
>  This is true.  They Generate what's called a "split lock" bus
> transaction where the bus will hold LOCK# low across the several clock
> cycles to  complete the write.  They are **VERY** heavy, BTW, and
> really cause  nasty performance hits. 

Is it worth making put_unaligned and get_unaligned on x86 avoid this by 
loading/storing the two halves of the required datum separately, then? 

--
dwmw2


