Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRJYMsX>; Thu, 25 Oct 2001 08:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273358AbRJYMsP>; Thu, 25 Oct 2001 08:48:15 -0400
Received: from mail317.mail.bellsouth.net ([205.152.58.177]:4948 "EHLO
	imf17bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S273261AbRJYMsD>; Thu, 25 Oct 2001 08:48:03 -0400
Message-ID: <3BD80A32.16D618FD@mandrakesoft.com>
Date: Thu, 25 Oct 2001 08:48:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Svedberg <thsv@bigfoot.com>
CC: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: Network device problems
In-Reply-To: <1004013479.2597.50.camel@athlon1.hemma.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Svedberg wrote:
> 
> Just updated to RedHat 7.2 and after compiling and starting my new
> kernel my network interfaces won't go up (not even lo), I get the
> following message:
> "ifup: Cannot send dump request: Connection refused".
> 
> Tried kernels 2.4.12-ac2 and -ac6 (One of my -ac2 kernels worked fine
> before the upgrade).
> 
> Using the RedHat precompiled kernels it works (but then I have no lVM)
> 
> Anyone have any clues ?

Yep.  Newer initscripts from RedHat and Mandrake (and others?) require
CONFIG_NETLINK_DEV.  initscripts runs, IIRC, iproute, which in turn
requires the netlink device.

I have a feeling this is going to be a FAQ.  Pretty much anybody who
uses these initscripts and compiles their own kernel !CONFIG_NETLINK_DEV
will hit this.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

