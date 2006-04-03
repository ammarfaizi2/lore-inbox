Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWDCWk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWDCWk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWDCWk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:40:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62132
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964868AbWDCWk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:40:59 -0400
Date: Mon, 03 Apr 2006 15:40:48 -0700 (PDT)
Message-Id: <20060403.154048.133638224.davem@davemloft.net>
To: anton@samba.org
Cc: alan@lxorguk.ukuu.org.uk, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add prctl to change endian of a task
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060403223620.GC4704@krispykreme>
References: <200604021637.49759.ioe-lkml@rameria.de>
	<1143989770.29060.28.camel@localhost.localdomain>
	<20060403223620.GC4704@krispykreme>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Blanchard <anton@samba.org>
Date: Tue, 4 Apr 2006 08:36:20 +1000

> The aim is not to implement little endian binaries but to assist
> running portions of code in little endian mode. The thought is we could
> hook up qemu to it and avoid having to byteswap.
> 
> While ppc has byteswap integer loads it does not have byteswap floating
> point loads and a byteswap involves loading into the integer unit,
> performing the byteswap, storing to a temporary location and loading
> into the floating point unit. Rather slow.

Doesn't PPC have a PTE bit that does endian swapping?  Wouldn't
that be easier to use for something like qemu?
