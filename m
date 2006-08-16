Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWHPWaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWHPWaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWHPWaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:30:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57758
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932298AbWHPWaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:30:03 -0400
Date: Wed, 16 Aug 2006 15:29:19 -0700 (PDT)
Message-Id: <20060816.152919.88472383.davem@davemloft.net>
To: arnd@arndb.de
Cc: linuxppc-dev@ozlabs.org, akpm@osdl.org, jeff@garzik.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608170016.47072.arnd@arndb.de>
References: <200608162324.47235.arnd@arndb.de>
	<20060816.143203.11626235.davem@davemloft.net>
	<200608170016.47072.arnd@arndb.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Aug 2006 00:16:46 +0200

> Am Wednesday 16 August 2006 23:32 schrieb David Miller:
> > Can spidernet be told these kinds of parameters?  "N packets or
> > X usecs"?
> 
> It can not do exactly this but probably we can get close to it by

Oh, you can only control TX packet counts using bits in the TX ring
entries :(

Tigon3 can even be told to use different interrupt mitigation
parameters when the cpu is actively servicing an interrupt for
the chip.

Didn't you say spidernet's facilities were sophisticated? :)
This Tigon3 stuff is like 5+ year old technology.
