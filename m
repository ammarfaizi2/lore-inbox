Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSGHGWa>; Mon, 8 Jul 2002 02:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSGHGW3>; Mon, 8 Jul 2002 02:22:29 -0400
Received: from dsl-213-023-043-185.arcor-ip.net ([213.23.43.185]:58509 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314553AbSGHGW2>;
	Mon, 8 Jul 2002 02:22:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [OKS] Module removal
Date: Mon, 8 Jul 2002 08:22:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Werner Almesberger <wa@almesberger.net>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
References: <20020707220933.B11999@kushida.apsleyroad.org> <Pine.LNX.3.96.1020707201054.19682A-100000@gatekeeper.tmr.com> <20020708014626.B13387@kushida.apsleyroad.org>
In-Reply-To: <20020708014626.B13387@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17RRum-0001Y5-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 July 2002 02:46, Jamie Lokier wrote:
> Bill Davidsen wrote:
> > I think you have to do it with the use count, and there may well be
> > modules you can't remove safely.
> 
> I agree, this is the correct and clean thing to do.
> 
> It rather implies that any function in a module which calls
> MOD_{INC,DEC}_USE_COUNT should always be called from a non-module
> function which _itself_ protects the module from removal by temporarily
> bumping the use count.

That's not nice.  It requires the calling code to know it's calling a
module and it imposes the inc/dec overhead on callers even when the
target isn't compiled as a module.

-- 
Daniel
