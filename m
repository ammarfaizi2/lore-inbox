Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030864AbWKOSpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030864AbWKOSpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030863AbWKOSpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:45:46 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:48260 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1030856AbWKOSpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:45:44 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	<20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	<455A938A.4060002@garzik.org> <ada8xidz5zn.fsf@cisco.com>
	<Pine.LNX.4.64.0611150739110.3349@woody.osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Nov 2006 10:45:38 -0800
In-Reply-To: <Pine.LNX.4.64.0611150739110.3349@woody.osdl.org> (Linus Torvalds's message of "Wed, 15 Nov 2006 07:53:27 -0800 (PST)")
Message-ID: <adad57oy2el.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Nov 2006 18:45:38.0470 (UTC) FILETIME=[3E566C60:01C708E6]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > Huh?  The device can't generate any legacy interrupts once MSI is
 > > enabled.  As the PCI spec says:
 > 
 > PLEASE.
 > 
 > The spec is just so much toilet paper. The ONLY thing that matters is what 
 > real hardware does. So please please please PLEASE don't start quoting 
 > specs as a way to "prove your point". It is totally meaningless.

Sorry, I think you misunderstood.  I've certainly seen my share of
crazy devices doing things like endian-reversing the MSI address and
sending interrupt messages off into random space.  The only thing I
was disagreeing with was that Jeff suggested it was a driver bug not
to do pci_intx(0) when enabling MSI.

I don't doubt that there are broken devices out there that do generate
wire interrupts even when MSI is enabled.  I just don't think we
should go around "fixing" working, correct drivers for devices that
_do_ follow the spec.

 - R.
