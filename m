Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLXCXo>; Sat, 23 Dec 2000 21:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLXCXe>; Sat, 23 Dec 2000 21:23:34 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:1290 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S129458AbQLXCXS>; Sat, 23 Dec 2000 21:23:18 -0500
Date: Sun, 24 Dec 2000 12:52:12 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Cesar Eduardo Barros <cesarb@nitnet.com.br>
cc: David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: TCP keepalive seems to send to only one port
In-Reply-To: <20001223223814.A2281@flower.cesarb>
Message-ID: <Pine.LNX.4.31.0012241243440.17066-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2000, Cesar Eduardo Barros wrote:

> Then what do you do when you are behind a NAT? And how do you expire entries in
> ESTABLISHED state that could stay lingering forever without some sort of
> keepalive? (The FINs might have been lost due to a conectivity transient, so
> you can have another perfectly valid and alive connection with the same host,
> and application-level timeouts are useless for some applications
> (*cough*nc*cough*))

Typically, you choose a practical value for timing out inactive but
otherwise seemingly established TCP connections.  The 2.4 connection
tracking code (used for NAT) uses a value of five days for this.


- James
--
James Morris
<jmorris@intercode.com.au>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
