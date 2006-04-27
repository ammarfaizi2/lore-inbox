Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWD0KAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWD0KAz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWD0KAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:00:55 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:63326 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965066AbWD0KAy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:00:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H8JplBFsu38YA/6pYeKczDVsRcnKOkvn6pqOx7SZUYkWTb+9KR5EfT+7g6HOvsN0O3PTHhw534PVVdLnmMNc9r6+FK/31wuVE65z/a5TpUaGNLzRF265wsmFOpXzv/GNLAHQ08f0EMFco1YUB7XXu3pypPeOPso3PrIsm/HMDCA=
Message-ID: <58d0dbf10604270300s6b6d2e1dg54bcd8ad2d3a1571@mail.gmail.com>
Date: Thu, 27 Apr 2006 12:00:53 +0200
From: "Jan Kiszka" <jan.kiszka@googlemail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Van Jacobson's net channels and real-time
Cc: simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060427.011646.41961134.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <58d0dbf10604210153r208504d4r4a7f4139e711ff7f@mail.gmail.com>
	 <Pine.LNX.4.64.0604212332110.30761-100000@localhost>
	 <58d0dbf10604270109j13ba5208h78f9b4de891370a8@mail.gmail.com>
	 <20060427.011646.41961134.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/4/27, David S. Miller <davem@davemloft.net>:
>
> Can I recommend a trip to the local university engineering library for
> a quick readup on the current state of the art wrt.  packet
> classification algorithms?
>
> Barring that, a read of chapter 12 "Packet Classification"
> from Networking Algorithmics will give you a great primer.
>
> I'm suggesting this, because all I see is fishing around with
> painfully inefficient algorithms.
>
> In any event, the initial net channel implementation will likely just
> do straight socket hash lookups identical to how TCP does socket
> lookups in the current stack.  Full match on established sockets, and
> failing that fall back to the listening socket lookup which allows
> some forms of wildcarding.
>

Sorry that you had to remind of the different primary goals. I think
we may look for something pluggable to support both large-scale rule
tables as well as small ones for embedded RT-systems.

Jan
