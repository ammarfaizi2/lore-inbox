Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271254AbRHTOji>; Mon, 20 Aug 2001 10:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271260AbRHTOj2>; Mon, 20 Aug 2001 10:39:28 -0400
Received: from relay2.primushost.com ([207.244.125.21]:49141 "EHLO
	relay2.primushost.com") by vger.kernel.org with ESMTP
	id <S271254AbRHTOjK>; Mon, 20 Aug 2001 10:39:10 -0400
From: Jay Rogers <jay@rgrs.com>
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
In-Reply-To: <200108181627.UAA19351@ms2.inr.ac.ru> (kuznet@ms2.inr.ac.ru)
Subject: Re: PROBLEM: select() says closed socket readable
Reply-to: Jay Rogers <jay@rgrs.com>
In-Reply-To: <200108181627.UAA19351@ms2.inr.ac.ru>
Message-Id: <E15Yq81-0006o8-00@shell2.shore.net>
Date: Mon, 20 Aug 2001 10:34:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: kuznet@ms2.inr.ac.ru
> > For linux 2.4.2, select() indicates socket ready for read on a
> > socket that's never been connected. 
> 
> Right. It does not block on read, hence it is readable.

No, a socket that's never been connected isn't readable, hence
select() shouldn't be returning a value of 1 on it.

> >					 This is inconsistent
> 
> This is perfectly consistent. Reaction to bugs in applications
> is undefined.

No this behavior isn't consistent with previous versions of Linux
nor is it consistent with other implementations of Unix.
