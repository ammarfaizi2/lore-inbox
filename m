Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279727AbRJYH6s>; Thu, 25 Oct 2001 03:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279733AbRJYH6j>; Thu, 25 Oct 2001 03:58:39 -0400
Received: from smtp-rt-2.wanadoo.fr ([193.252.19.154]:3233 "EHLO
	apeiba.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279727AbRJYH6Y>; Thu, 25 Oct 2001 03:58:24 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 25 Oct 2001 09:58:32 +0200
Message-Id: <20011025075832.27776@smtp.wanadoo.fr>
In-Reply-To: <E15wWiC-0002uM-00@the-village.bc.nu>
In-Reply-To: <E15wWiC-0002uM-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I really don't think it's _that_ difficult to properly do this blocking.
>> For things like sound drivers, a simple semaphore is plenty enough. For
>
>Sound is more easily handled by not blocking user space but waiting until
>the final IRQ off moment and grabbing the registers. That avoids a lot
>of ugly locking gunge. It literally comes down to

My point about using a semaphore was to avoid getting mixer ioctls
banging the HW while it is shut down.

Ben.


