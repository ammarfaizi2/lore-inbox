Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271230AbRHOP2P>; Wed, 15 Aug 2001 11:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271228AbRHOP2F>; Wed, 15 Aug 2001 11:28:05 -0400
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:33552 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271227AbRHOP2A>; Wed, 15 Aug 2001 11:28:00 -0400
Date: Wed, 15 Aug 2001 16:27:04 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <Pine.LNX.3.95.1010815111856.28263A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0108151622570.2107-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Richard B. Johnson wrote:

> Same problem on 2.4.1. The first 512 bytes comes right away if
> /dev/random hasn't been accessed since boot, then the rest trickles
> a few words per second.

Hmm...  Well, ATM I've kludged a fix by using /dev/urandom instead, but
it's not ideal because it's being used to generate cryptographic keys, and
urandom isn't cryptographically secure.

Are you seeing the problem on a normal machine? (I assumed I was seeing it
because I'm using Cobalt hardware that's not going to get much entropy
data due to the lack of keyboard, etc)...  although when I'm generating
this data I'm using a root NFS filesystem, so there should be plenty of
network interrupts happening,which should generate some entropy...

I might have a look into increasing the size of the entropy pool so
there's more data to access at once...

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


