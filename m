Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKAUF3>; Wed, 1 Nov 2000 15:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbQKAUFU>; Wed, 1 Nov 2000 15:05:20 -0500
Received: from animal.cs.chalmers.se ([129.16.225.30]:33244 "EHLO
	animal.cs.chalmers.se") by vger.kernel.org with ESMTP
	id <S129055AbQKAUFI>; Wed, 1 Nov 2000 15:05:08 -0500
Date: Wed, 1 Nov 2000 21:05:00 +0100 (MET)
From: Dennis Bjorklund <dennisb@cs.chalmers.se>
To: William T Wilson <fluffy@snurgle.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcast
In-Reply-To: <Pine.LNX.4.21.0011011423420.21946-100000@benatar.snurgle.org>
Message-ID: <Pine.SOL.4.21.0011012058290.20182-100000@muppet17.cs.chalmers.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, William T Wilson wrote:

> If rwhod doesn't have an option as to which address to bind to, your only
> choice is to block its communication with ipchains.

I don't think you can specify the addresses. It looks at the interfaces
and sends to the ones that can broadcast.

I have solved it with ipchains but then rwhod fills my /var/log/messages
with lines like:

Nov 1 20:40:28 x rwhod[650]: sendto(192.168.0.1): Operation not permitted
Nov 1 20:43:28 x rwhod[650]: sendto(192.168.0.1): Operation not permitted
Nov 1 20:46:28 x rwhod[650]: sendto(192.168.0.1): Operation not permitted

It's a lot of messages...

So if you cant turn of broadcast why does ifconfig have an option that
says it turns of broadcast.

 [-]broadcast [addr]
    If the address  argument  is  given,  set  the  protocol broadcast
    address   for  this  interface.   Otherwise,  set  (or clear)  the
    IFF_BROADCAST flag for the interface.

And rwhod looks at the IFF_BROADCAST flag.

/Dennis

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
