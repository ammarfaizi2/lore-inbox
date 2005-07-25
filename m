Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVGYKVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVGYKVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 06:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVGYKVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 06:21:15 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:55955 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261187AbVGYKVO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 06:21:14 -0400
Date: Mon, 25 Jul 2005 03:21:04 -0700
From: Tony Lindgren <tony@atomide.com>
To: Voluspa <lista1@telia.com>
Cc: Pavel Machek <pavel@ucw.cz>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-ID: <20050725102103.GG5837@atomide.com>
References: <20050721200448.5c4a2ea0.lista1@telia.com> <9a8748490507211114227720b0@mail.gmail.com> <20050722144855.GA2036@elf.ucw.cz> <20050722191510.5e120515.voluspa@telia.com> <20050722180236.GA615@atrey.karlin.mff.cuni.cz> <20050722204439.54a63a00.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722204439.54a63a00.lista1@telia.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Voluspa <lista1@telia.com> [050722 11:46]:
> On Fri, 22 Jul 2005 20:02:36 +0200 Pavel Machek wrote:
> > will not help. It seems like your machine is simply not able to do
> > reasonable powersaving.
> 
> Digging up this patch from last month regarding C2 on a AMD K7 implies
> that the whole blame can be put on kernel acpi:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111933745131301&w=2

AFAIK Linux ACPI expects BIOS to contain all the necessary stuff to enable
C2 and C3. Otherwise they won't get enabled, and you have to create a custom
module like the amd76x_pm is.

There's been some talk on adding a module to enable C2 and C3 states for
various chipsets, but nobody seems to have enough time to do it...

Tony
