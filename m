Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161736AbWKOWnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161736AbWKOWnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162021AbWKOWnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:43:19 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:40365 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1162018AbWKOWnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:43:18 -0500
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<p73ejs5co0q.fsf@bingen.suse.de> <adazmatxq66.fsf@cisco.com>
	<200611150611.13623.ak@suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Nov 2006 14:43:16 -0800
In-Reply-To: <200611150611.13623.ak@suse.de> (Andi Kleen's message of "Wed, 15 Nov 2006 06:11:13 +0100")
Message-ID: <ada8xicwcu3.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Nov 2006 22:43:16.0555 (UTC) FILETIME=[70D189B0:01C70907]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Perhaps with special user space quirks, but not in mainline kernel because it's
 > not force enabled (see erratum #78).

I just looked at the revision guide again, and I don't see why erratum
#78 would matter -- that seems to be saying that the bridge itself
doesn't have an MSI capability so it can't generate MSI interrupts
itself.  But why does that matter for devices below the bridge?

Anyway I have some HP DL145 G2 servers with 8132 bridges in them.
I'll plug an MSI-capable PCI-X card in and see what happens.  So far
I've only used PCIe cards in my systems (but MSI-X works fine there,
with nVidia host bridges).

 - R.
