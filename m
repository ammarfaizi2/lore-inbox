Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVIMILA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVIMILA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVIMILA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:11:00 -0400
Received: from colin.muc.de ([193.149.48.1]:269 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932437AbVIMIK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:10:59 -0400
Date: 13 Sep 2005 10:10:54 +0200
Date: Tue, 13 Sep 2005 10:10:54 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/14] x86_64: Use common functions in cluster and physflat mode
Message-ID: <20050913081054.GB37889@muc.de>
References: <200509032135.j83LZ8gX020554@shell0.pdx.osdl.net> <20050905231628.GA16476@muc.de> <20050906161215.B19592@unix-os.sc.intel.com> <Pine.LNX.4.61.0509091003490.978@montezuma.fsmlabs.com> <20050909134503.A29351@unix-os.sc.intel.com> <Pine.LNX.4.61.0509091439110.978@montezuma.fsmlabs.com> <20050911230220.GA73228@muc.de> <20050912152308.A18649@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912152308.A18649@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We should probably remove the !HOTPLUG case and just use the mask version
> for all cases <=8 CPUS, use physflat or the cluster mode for >8cpus as 
> the case may be, instead of defaulting to sequence_IPI which seems
> a little overkill for the intended purpose.

Or just always use physflat and remove the logical flat case? 
That seems cleanest to me. Any objections? 

-Andi
