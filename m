Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269378AbRGaRLU>; Tue, 31 Jul 2001 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269377AbRGaRLK>; Tue, 31 Jul 2001 13:11:10 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:17105 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S269373AbRGaRKz>; Tue, 31 Jul 2001 13:10:55 -0400
Message-Id: <4.3.1.0.20010731100209.05fce100@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Tue, 31 Jul 2001 10:11:49 -0700
To: "David S. Miller" <davem@redhat.com>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [PATCH] netif_rx from non interrupt context
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, torvalds@transmeta.com,
        kuznet@ms2.inr.ac.ru
In-Reply-To: <15206.3993.800893.762127@pizda.ninka.net>
In-Reply-To: <4.3.1.0.20010730121828.05eaf310@mail1>
 <4.3.1.0.20010730121828.05eaf310@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


>  > Generic function for the net drivers that call netif_rx from non interrupt context.
>  > And TUN/TAP driver patch.
>
>No, let us do it explicitly in the drivers, not create a new API for this.
Well, the thing is that we can probably optimize that function (like you guys did for a local_bh_enable) because it's
a critical path. Also it makes sense (to me) to hide softirq implementation details from the net drivers.
If softirqs are changed again we can fix one place instead of auditing net drivers.

>Maybe we should add "Send to socket with BH disabled" or a "insert to generic linked list with spinlock held" interfaces too ? :-)
:-) 

Max

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net

