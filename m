Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135345AbRECWr3>; Thu, 3 May 2001 18:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135353AbRECWrT>; Thu, 3 May 2001 18:47:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3338 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135345AbRECWrL>; Thu, 3 May 2001 18:47:11 -0400
Subject: Re: skb->truesize > sk->rcvbuf == Dropped packets
To: mike_phillips@urscorp.com
Date: Thu, 3 May 2001 23:51:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OFE81E1255.065B9900-ON84256A41.007639FA@urscorp.com> from "mike_phillips@urscorp.com" at May 03, 2001 07:29:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vRwC-0006NV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can implement one solution by copying the received packets into skb's 
> with the correct length, but that eliminates the performance gains from 
> simply swapping buffers around (and would definately mean no zero-copy). 

Generally it is a win to copy rather than swap buffers when the frame does
not occupy most of the buffer. Most traffic is very small or MTU sized
frames (and on TR of course ethernet not TR mtu frames are popular)

