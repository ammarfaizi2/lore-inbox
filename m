Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUCRCAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 21:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUCRCAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 21:00:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53711 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262294AbUCRCAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 21:00:15 -0500
Message-ID: <405902A2.8060801@pobox.com>
Date: Wed, 17 Mar 2004 21:00:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-raid@vger.kernel.org, justin_gibbs@adaptec.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
References: <1AOTW-4Vx-7@gated-at.bofh.it> <1AOTW-4Vx-5@gated-at.bofh.it> <m3wu5jey76.fsf@averell.firstfloor.org>
In-Reply-To: <m3wu5jey76.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Sorry, Jeff, but that's just not true. While ioctls need an additional
> entry in the conversion table, they can at least easily get an
> translation handler if needed. When they are correctly designed you
> just need a single line to enable pass through the emulation.
> If you don't want to add that line to the generic compat_ioctl.h
> file you can also do it in your driver.
> 
> read/write has the big disadvantage that if someone gets the emulation
> wrong (and that happens regularly) it is near impossible to add an 
> emulation handler then, because there is no good way to hook
> into the read/write paths.
> 
> There may be valid reasons to go for read/write, but 32bit emulation
> is not one of them. In fact from the emulation perspective read/write
> should be avoided.

I'll probably have to illustrate with code, but basically, read/write 
can be completely ignorant of 32/64-bit architecture, endianness, it can 
even be network-transparent.  ioctls just can't do that.

	Jeff



