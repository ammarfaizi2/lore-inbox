Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVC3HVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVC3HVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVC3HVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:21:13 -0500
Received: from gate.ebshome.net ([64.81.67.12]:22418 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S261788AbVC3HVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:21:11 -0500
Date: Tue, 29 Mar 2005 23:21:10 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Ara Avanesyan <araav@hylink.am>
Cc: linux-kernel@vger.kernel.org, avila@lists.unixstudios.net
Subject: Re: Strange memory problem with Linux booted from U-Boot
Message-ID: <20050330072110.GA7027@gate.ebshome.net>
Mail-Followup-To: Ara Avanesyan <araav@hylink.am>,
	linux-kernel@vger.kernel.org, avila@lists.unixstudios.net
References: <006b01c5047e$1efc78a0$1000000a@araavanesyan> <20050127144441.GB4848@home.fluff.org> <00ae01c533a6$85ddf1f0$1000000a@araavanesyan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ae01c533a6$85ddf1f0$1000000a@araavanesyan>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 07:57:52PM +0500, Ara Avanesyan wrote:
> Hi,
> 
> I need some help on solving this strange problem.
> Here is what I have,
> I have a loadable module (linux.2.4.20) which contains a 2 mb static gloabal
> array.
> When I load it from linux booted via U-Boot the system crashes.
> Everything works ok if I do the same thing with the same linux booted with
> RedBoot.

As usual for such problems, check how different firmware configure 
memory controller, etc. Get dump of relevant chip registers under 
U-Boot and RedBoot and compare them.

Other possible problem area can be firmware -> kernel interface. I'm 
not familiar with that particular chip and RedBoot, but it's not 
uncommon for different firmware to have different conventions for the 
environment in which kernel starts execution.

I'd recommend posting to the specific mail-lists, lkml doesn't seem 
a good place for embedded and firmware related questions :)

--
Eugene
