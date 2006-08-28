Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWH1JWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWH1JWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWH1JWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:22:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:9403 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751326AbWH1JWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:22:44 -0400
From: Andi Kleen <ak@suse.de>
To: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [patch] fix up smp alternatives on x86-64
Date: Mon, 28 Aug 2006 11:22:38 +0200
User-Agent: KMail/1.9.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <44F2B557.6020403@suse.de>
In-Reply-To: <44F2B557.6020403@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281122.38829.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 11:20, Gerd Hoffmann wrote:
> Don't use alternative_smp() in for __raw_spin_lock.  gcc
> sometimes generates rip-relative addressing, so we can't
> simply copy the instruction to another place.
> 
> Replace some leftover "lock;" with LOCK_PREFIX.
> 
> Fillup space with 0x90 (nop) instead of 0x42, so
> "objdump -d -j .smp_altinstr_replacement vmlinux" gives more
> readable results.

I already fixed it myself.

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/remove-alternative-smp
ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/i386-remove-alternative-smp

And all the left over lock prefixes are also gone in that tree.

-Andi
