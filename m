Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423424AbWJZMbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423424AbWJZMbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423457AbWJZMbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:31:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:44322 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1423424AbWJZMa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:30:58 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,361,1157353200"; 
   d="scan'208"; a="150974992:sNHT23160515"
Message-ID: <4540AA7E.4050703@intel.com>
Date: Thu, 26 Oct 2006 20:30:54 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] i386 create e820.c to handle e820/efi memory map table
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
  On i386 there are legacy bios and efi bios, memory map table handling
between legacy bios and efi bios is different, this brings some confusion
about memory map table handing. This patch creates new file named e820.c
to put bios memory map table relative functions together, it is something
the same with x86_64 arch.
  This patch set only moves function from setup.c to e820.c. There is no any
function modification , except that static declaration for some functions are
removed because these functions will be called in other files. 
  With this patch, function handling about bios memory map table is more
explicit, easier to handle memmap table between legacy bios and efi bios.
  This patch is divided fives parts, each parts can compile and run well in
my machine. Any comments and suggestion is welcome.
  
Signed-off-by: bibo,mao <bibo.mao@intel.com>
