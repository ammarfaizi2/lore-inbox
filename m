Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUHWSiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUHWSiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUHWSiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:38:17 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:58098 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266573AbUHWS2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:28:02 -0400
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [broken?] Add MSI support to e1000
X-Message-Flag: Warning: May contain useful information
References: <2wpoS-1ai-1@gated-at.bofh.it> <2wqXF-2jm-29@gated-at.bofh.it>
	<m3oel1hg77.fsf@averell.firstfloor.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 23 Aug 2004 11:26:30 -0700
In-Reply-To: <m3oel1hg77.fsf@averell.firstfloor.org> (Andi Kleen's message
 of "Mon, 23 Aug 2004 20:17:32 +0200")
Message-ID: <52acwlvhgp.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Aug 2004 18:26:30.0514 (UTC) FILETIME=[B5D9BD20:01C4893E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> There seems to be something wrong with the MSI code in the
    Andi> kernel.  I tried to add MSI support to the s2io driver on
    Andi> x86-64, but it just didn't work (/proc/interrupts still
    Andi> displayed IO-APIC mode). I haven't investigated in detail
    Andi> yet though.

Hmm... I've not tried MSI on x86-64 (although I have tried it on
Nocona running a 32-bit kernel).  I have successfully used both MSI
and MSI-X on i386 with my mthca (InfiniBand HCA) driver, although with
some occasional stability glitches, which may be connected to the
e1000 problem I'm seeing.  In any case, /proc/interrupts definitely
shows "PCI-MSI" mode with a non-zero number of interrupts delivered
with my patched e1000 driver.

 - Roland

