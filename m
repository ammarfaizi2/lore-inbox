Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269078AbUJEOAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269078AbUJEOAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269833AbUJEOAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:00:10 -0400
Received: from zero.aec.at ([193.170.194.10]:40462 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269937AbUJEN5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:57:10 -0400
To: Hideo AOKI <aoki@sdl.hitachi.co.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6]  vm-thrashing-control-tuning
References: <2LXI2-3a5-21@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 05 Oct 2004 15:57:03 +0200
In-Reply-To: <2LXI2-3a5-21@gated-at.bofh.it> (Hideo AOKI's message of "Tue,
 05 Oct 2004 15:40:14 +0200")
Message-ID: <m3ekkd46a8.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hideo AOKI <aoki@sdl.hitachi.co.jp> writes:

> This patch adds "swap_token_timeout" parameter in /proc/sys/vm.
> The parameter means expired time of token. Unit of the value is HZ, and the default value is the same as current SWAP_TOKEN_TIMEOUT
> (i.e. HZ * 300). The patch can be applied to both 2.6.9-rc2 and 2.6.9-rc3.


Please don't export any sysctls as jiffies. The values of jiffies changes.
Use s or ms instead. sysctl has convenience functions for this.

-Andi

