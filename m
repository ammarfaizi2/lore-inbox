Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbRGBQ6V>; Mon, 2 Jul 2001 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265337AbRGBQ6K>; Mon, 2 Jul 2001 12:58:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16907 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265336AbRGBQ54>; Mon, 2 Jul 2001 12:57:56 -0400
Subject: Re: [RFC] I/O Access Abstractions
To: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 2 Jul 2001 17:56:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dhowells@redhat.com (David Howells),
        jes@sunsite.dk (Jes Sorensen), linux-kernel@vger.kernel.org,
        arjanv@redhat.com
In-Reply-To: <19921.994092096@redhat.com> from "David Woodhouse" at Jul 02, 2001 05:41:36 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15H70K-0006Cn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because if we just pass in this one extra piece of information which is
> normally already available in the driver, we can avoid a whole lot of ugly
> cruft in the out-of-line functions by plugging in the correct out-of-line 
> function to match the resource. 

Case 1:
	You pass a single cookie to the readb code
	Odd platforms decode it

Case 2:
	You carry around bus number information all throughout
		each driver
	You keep putting it on/off the stack
	You keep it in structures
	You do complex generic locking for hotplug 'just in case'


I think I prefer case 1.

