Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137165AbREKQXG>; Fri, 11 May 2001 12:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137166AbREKQW4>; Fri, 11 May 2001 12:22:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2571 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S137165AbREKQWi>; Fri, 11 May 2001 12:22:38 -0400
Subject: Re: x86 bootmem corruption
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 11 May 2001 17:18:35 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010511180737.Q30355@athlon.random> from "Andrea Arcangeli" at May 11, 2001 06:07:37 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yFci-0001Ho-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> reserved.  This is the fix against 2.4.5pre1. This might explain weird
> crashes and "reserved twice" error messages at boot on highmem systems.

Reserved twice occurs for two known reasons

BIOS reporting the same region twice or overlaps (fixed in -ac sent to Linus)
find_smp_config blindly reserves pages that may already be marked as ROM and
thus reserved anyway

