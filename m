Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263405AbTDCPFS>; Thu, 3 Apr 2003 10:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263411AbTDCPFS>; Thu, 3 Apr 2003 10:05:18 -0500
Received: from ns.suse.de ([213.95.15.193]:14854 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263405AbTDCPFR>;
	Thu, 3 Apr 2003 10:05:17 -0500
Date: Thu, 3 Apr 2003 17:16:43 +0200
From: Andi Kleen <ak@suse.de>
To: mikpe@csd.uu.se
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.66 x86_64 oops when swapoff via IA32 emulation
Message-ID: <20030403151642.GB2062@wotan.suse.de>
References: <16012.19359.948383.217572@enequist.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16012.19359.948383.217572@enequist.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 04:56:31PM +0200, mikpe@csd.uu.se wrote:
> I got this oops from swapoff when shutting down 2.5.66 on
> x86_64 with 32-bit user-space (RH8.0). This was from the first
> run with 2.5.66, I wasn't able to reproduce it in later runs.

Is this on the Simulator or on a real Opteron/Athlon64? 

On the real CPU there is a known bug I wasn't able to track down yet - 
pci_free_consistent() seems to corrupt memory. When you do a shutdown
this is usually invoked in some driver's cleanup function (e.g. ifconfig
down on a network driver) and causes something later to crash.

-Andi

