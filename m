Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161341AbWKPRZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161341AbWKPRZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 12:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWKPRZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 12:25:19 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:49974 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1161341AbWKPRZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 12:25:17 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <455A938A.4060002@garzik.org>
	<20061114.201549.69019823.davem@davemloft.net>
	<455A9664.50404@garzik.org>
	<20061114.202814.70218466.davem@davemloft.net>
	<1163643937.5940.342.camel@localhost.localdomain>
	<455BDA1D.5090409@garzik.org>
	<1163650341.5940.361.camel@localhost.localdomain>
	<455C0176.5090107@garzik.org> <m3u00z4fnv.fsf@defiant.localdomain>
	<455C8350.3050309@garzik.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Nov 2006 09:24:59 -0800
In-Reply-To: <455C8350.3050309@garzik.org> (Jeff Garzik's message of "Thu, 16 Nov 2006 10:27:12 -0500")
Message-ID: <adau00ztic4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Nov 2006 17:25:00.0303 (UTC) FILETIME=[24FA79F0:01C709A4]
Authentication-Results: sj-dkim-7; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim7002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Most interrupt-driven devices have an interrupt mask register of some
 > sort.  The nice thing about PCI_COMMAND_INTX_DISABLE is that it is
 > standardized.

You all got on me about quoting the spec about not generating INTx
interrupts after MSI is enabled.  What makes you think that setting
some bit in the command register, which wasn't even standardized until
PCI 2.3 and which most hardware designers probably forgot about, is
going to work on broken devices?

 - R.
