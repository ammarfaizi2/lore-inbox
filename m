Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318293AbSHUODe>; Wed, 21 Aug 2002 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318295AbSHUODe>; Wed, 21 Aug 2002 10:03:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39662 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318293AbSHUODa>; Wed, 21 Aug 2002 10:03:30 -0400
Subject: Re: shared graphic ram hangs kernel since 2.4.3-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Justin Heesemann <jh@ionium.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208211529.56917.jh@ionium.org>
References: <200208201527.51649.jh@ionium.org>
	<200208211352.29994.jh@ionium.org>
	<1029935812.26425.0.camel@irongate.swansea.linux.org.uk> 
	<200208211529.56917.jh@ionium.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 15:08:40 +0100
Message-Id: <1029938920.26425.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 14:29, Justin Heesemann wrote:
> > Are you running a very old version of grub ?
> 
> actually i am running lilo..
> the one that comes with debian 3.0.
> the problem also occurs with every bootable linux cd, that i tried.. as long 
> as it's running kernel 2.4.19.
> debian bf24 kernel image (i think its 2.4.16?) is booting when i append 
> mem=511M, knoppix/gentoo with 2.4.19 doesnt.
> 
> would you suggest that i try grub ?

It shouldnt make any difference. Very old grb always passed mem=, which
did break some things because at one point it overrode the reporting of
holes and the like.

Shared graphic ram shouldnt in theory ever be causing hangs. The BIOS
E820 memory reporting should be excluding any video reserved memory from
its reporting. For the i810/845 its fractionally more complex once we go
into X11 (we allocate from the AGP pool ourselves) but not in console
mode.

