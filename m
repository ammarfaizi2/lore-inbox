Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVIZG7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVIZG7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVIZG7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:59:05 -0400
Received: from colin.muc.de ([193.149.48.1]:41738 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932413AbVIZG7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:59:04 -0400
Date: 26 Sep 2005 08:58:56 +0200
Date: Mon, 26 Sep 2005 08:58:56 +0200
From: Andi Kleen <ak@muc.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, discuss@x86-64.org
Subject: Re: init and zap low address mappings on demand for cpu hotplug
Message-ID: <20050926065856.GA99750@muc.de>
References: <20050921135731.B14439@unix-os.sc.intel.com> <20050922094818.GB79762@muc.de> <20050923172855.D12631@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923172855.D12631@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch introduces boot_level4_pgt, which will always have low identity
> addresses mapped. Druing boot, all the processors will use this as their
> level4 pgt. On BP, we will switch to init_level4_pgt as soon as we enter
> C code and  zap the low mappings as soon as we are done with the usage of 
> identity low mapped addresses. On AP's we will zap the low mappings as 
> soon as we jump to C code.

Looks good. Thanks Suresh. The boot page tables should be marked __initdata
now, but that can be done in an follow on patch.

i386 should probably get similar treatment.

-Andi

