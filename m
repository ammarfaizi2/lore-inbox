Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSJAR4V>; Tue, 1 Oct 2002 13:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbSJAR4V>; Tue, 1 Oct 2002 13:56:21 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:64466 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S262208AbSJAR4V>;
	Tue, 1 Oct 2002 13:56:21 -0400
Date: Tue, 1 Oct 2002 20:01:47 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Generic HDLC interface continued
Message-ID: <20021001200147.A16700@fafner.intra.cogenit.fr>
References: <m3y99nrtsu.fsf@defiant.pm.waw.pl> <20020928202138.A17244@se1.cogenit.fr> <m3smzsnbx9.fsf@defiant.pm.waw.pl> <20020930225437.A19967@se1.cogenit.fr> <m3n0pzm43c.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3n0pzm43c.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Tue, Oct 01, 2002 at 01:48:23AM +0200
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
[...]
> Please note that there is no call which could return the protocol
> (or interface type) without copying the whole data - thus the caller
> (utility) is unable to skip unknown interfaces.

Ok, the 'type' attribute isn't enough.

I feel like we are trying to do two things at the same time:
a) the size of the allocated area isn't required if we need to do something
   real with the data: if size doesn't match what is expected, we loose 
   anyway
b) if we don't care about the copied data, we actually ask for the subtype
   of the interface

-> a) and b) are two different operations imho.

-- 
Ueimor
