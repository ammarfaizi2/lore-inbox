Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVJ3Kqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVJ3Kqg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 05:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVJ3Kqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 05:46:36 -0500
Received: from cantor2.suse.de ([195.135.220.15]:55238 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932068AbVJ3Kqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 05:46:35 -0500
From: Andreas Schwab <schwab@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Michal Srajer <michal@mat.uni.torun.pl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/etherdevice.h, kernel 2.6.14
References: <20051029141046.GA17715@ultra60.mat.uni.torun.pl>
	<20051029141757.GA14039@flint.arm.linux.org.uk>
	<20051029154027.GC17715@ultra60.mat.uni.torun.pl>
	<20051029160019.GB14039@flint.arm.linux.org.uk>
	<95B34D3D-B658-4933-81CF-4DA25BD0F37F@able.es>
X-Yow: I invented skydiving in 1989!
Date: Sun, 30 Oct 2005 11:46:27 +0100
In-Reply-To: <95B34D3D-B658-4933-81CF-4DA25BD0F37F@able.es> (J. A. Magallon's
	message of "Sat, 29 Oct 2005 23:36:57 +0200")
Message-ID: <je7jbv5lks.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> writes:

> Just for curiosity, could you both benchmark this also:
>
> int is_zero_ether_addr0(const unsigned char *addr)
> {
>     return !(((unsigned long *)addr)[0] | ((unsigned short*)addr)[2]);
> }

It's probably slower when addr is unaligned, especially when unaligned
accesses need to be emulated.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
