Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVGHJTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVGHJTa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVGHJTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:19:30 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:62872 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262330AbVGHJT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:19:28 -0400
Date: Fri, 8 Jul 2005 13:19:14 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tero Roponen <teanropo@cc.jyu.fi>
Cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Re: 2.6.13-rc2 hangs at boot
Message-ID: <20050708131914.B8779@jurassic.park.msu.ru>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi> <9e47339105070618273dfb6ff8@mail.gmail.com> <20050707135928.A3314@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi> <20050707163140.A4006@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071546560.29406@tukki.cc.jyu.fi> <20050707174158.A4318@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071709170.697@tukki.cc.jyu.fi> <20050708102852.B612@den.park.msu.ru> <Pine.GSO.4.58.0507081057001.8935@tukki.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.58.0507081057001.8935@tukki.cc.jyu.fi>; from teanropo@cc.jyu.fi on Fri, Jul 08, 2005 at 10:57:56AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 10:57:56AM +0300, Tero Roponen wrote:
> Thanks! Vanilla 2.6.13-rc2 with below patch applied
> works perfectly!

Thanks for testing. Though, bad news are that it's still unclear
why your machine doesn't like large cardbus windows and therefore
how to fix that correctly.

May I ask you to do couple of another tests with following variations
of the latest patch (this will help to determine whether it's IO or
MEM ranges to blame)?
1. 
#define CARDBUS_IO_SIZE		(256)
#define CARDBUS_MEM_SIZE	(32*1024*1024)

2.
#define CARDBUS_IO_SIZE		(4096)
#define CARDBUS_MEM_SIZE	(4*1024*1024)

Ivan.
