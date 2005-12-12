Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVLLUj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVLLUj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVLLUj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:39:27 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45451 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750952AbVLLUj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:39:27 -0500
Date: Mon, 12 Dec 2005 14:39:23 -0600
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: EXPORT_PER_CPU_SYMBOL() does not generate a CRC.
Message-ID: <20051212203922.GE30381@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling for ia64, the following warning message is omitted:

*** Warning: "per_cpu____sn_nodepda" [arch/ia64/sn/kernel/xpc.ko] has
no CRC!

The definition for this is:
DEFINE_PER_CPU(struct nodepda_s *, __sn_nodepda);
EXPORT_PER_CPU_SYMBOL(__sn_nodepda);


I modified arch/ia64/defconfig to include:
CONFIG_IA64_SGI_SN_XP=m

I was going to look into this unless someone already knows the correct
fix for the problem.

Thanks,
Robin Holt
