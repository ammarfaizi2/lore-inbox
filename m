Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135881AbRDYPQs>; Wed, 25 Apr 2001 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135880AbRDYPQj>; Wed, 25 Apr 2001 11:16:39 -0400
Received: from t2.redhat.com ([199.183.24.243]:761 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135881AbRDYPQ2>; Wed, 25 Apr 2001 11:16:28 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200104251459.f3PEx8s4009505@pincoya.inf.utfsm.cl> 
In-Reply-To: <200104251459.f3PEx8s4009505@pincoya.inf.utfsm.cl> 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Sergey Kubushin" <ksi@cyberbills.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3ac13 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 25 Apr 2001 16:15:57 +0100
Message-ID: <22221.988211757@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vonbrand@inf.utfsm.cl said:
>  AFAIR, this means that the driver is using an udelay() with a much
> too large argument. Break it up into several shorter ones, or use
> mdelay().

That isn't necessarily the case. This code can break even with _correct_ 
arguments to udelay().

This is because despite the number of times this kind of thing has bitten
us, we _still_ haven't learned our lesson w.r.t. depending on specifications
rather than the observed behaviour of this week's compiler with this
particular phase of the moon.

--
dwmw2


