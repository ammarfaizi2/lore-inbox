Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262975AbSJBFvg>; Wed, 2 Oct 2002 01:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262978AbSJBFvg>; Wed, 2 Oct 2002 01:51:36 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:33497 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S262975AbSJBFvf>;
	Wed, 2 Oct 2002 01:51:35 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: Generic HDLC interface continued
References: <m3y99nrtsu.fsf@defiant.pm.waw.pl>
	<20020928202138.A17244@se1.cogenit.fr>
	<m3smzsnbx9.fsf@defiant.pm.waw.pl>
	<20020930225437.A19967@se1.cogenit.fr>
	<m3n0pzm43c.fsf@defiant.pm.waw.pl>
	<20021001200147.A16700@fafner.intra.cogenit.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 02 Oct 2002 00:09:33 +0200
In-Reply-To: <20021001200147.A16700@fafner.intra.cogenit.fr>
Message-ID: <m3fzvpolpe.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> Ok, the 'type' attribute isn't enough.
> 
> I feel like we are trying to do two things at the same time:
> a) the size of the allocated area isn't required if we need to do something
>    real with the data: if size doesn't match what is expected, we loose 
>    anyway
> b) if we don't care about the copied data, we actually ask for the subtype
>    of the interface
> 
> -> a) and b) are two different operations imho.

Depends on the point of view, but generally it might be true.
However, it is quite practical to do a+b in one call:
- utilities will always do it in exactly that order,
- we don't need to worry about races (process A gets type/size; process
  B changes protocol; process A gets invalid data).
-- 
Krzysztof Halasa
Network Administrator
