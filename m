Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130391AbQKAT2i>; Wed, 1 Nov 2000 14:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131152AbQKAT22>; Wed, 1 Nov 2000 14:28:28 -0500
Received: from c266492-a.lakwod1.co.home.com ([24.1.8.253]:45327 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP
	id <S130391AbQKAT2Q>; Wed, 1 Nov 2000 14:28:16 -0500
Date: Wed, 1 Nov 2000 14:27:36 -0500 (EST)
From: William T Wilson <fluffy@snurgle.org>
To: Dennis Bjorklund <dennisb@cs.chalmers.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcast
In-Reply-To: <Pine.SOL.4.21.0011012010340.19399-100000@muppet17.cs.chalmers.se>
Message-ID: <Pine.LNX.4.21.0011011423420.21946-100000@benatar.snurgle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Dennis Bjorklund wrote:

> I'm trying to turn of the broadcast flag for a network card. But I
> can't, why??

Broadcast determines the type of connection - broadcast or point-to-point
(there can be other types also, but you will not see them much).

You wouldn't want to do this anyway.  It means Ethernet broadcasts, not IP
broadcasts.  IP will not work over Ethernet without broadcasts.

> I have two network-cards in the machine and an application (rwhod)
> that wants to send it's messages out on every interface that can
> broadcast. But never want to broadcast anything on this interface so
> why not turn it of? If I could that is..

Do you really need rwhod at all?

If rwhod doesn't have an option as to which address to bind to, your only
choice is to block its communication with ipchains.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
