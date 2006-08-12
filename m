Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWHLF1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWHLF1s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 01:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWHLF1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 01:27:48 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39081 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932323AbWHLF1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 01:27:47 -0400
Date: Fri, 11 Aug 2006 22:27:44 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: mlord@pobox.com, axboe@suse.de, sam@ravnborg.org, zippel@linux-m68k.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: VMPLIT question
Message-ID: <20060812052744.GB4919@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While building a newer kernel for a server (which had been running
2.6.12 or so), I spent some time looking for how to set the VMSPLIT
.config options. I searched in menuconfig for VMSPLIT and was given a
few responses, all similar to this:

  │ Symbol: VMSPLIT_3G [=n]
  │ Prompt: 3G/1G user/kernel split
  │   Defined at arch/i386/Kconfig:488
  │   Depends on: <choice>             

Since depending on "<choice>" is less than helpful, I did an rgrep and
found what it actually depends on:

  depends on EXPERIMENTAL && !X86_PAE
  prompt "Memory split" if EMBEDDED
  default VMSPLIT_3G

and was able to determine that I needed the patch recently submitted by
Dave Hansen to enable VMSPLIT for highmem kernels. Is there a reason
that menuconfig is not able to tell me this, i.e. this is a known
limitation of the choice syntax?

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
