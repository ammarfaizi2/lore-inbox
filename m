Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVAFGyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVAFGyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 01:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVAFGyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 01:54:22 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:13573 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S262193AbVAFGyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 01:54:18 -0500
Message-ID: <41DCE08B.5010507@snapgear.com>
Date: Thu, 06 Jan 2005 16:54:03 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.10-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.10.

I have completely reworked the startup code for the m68knommu
architectures. What was dozens of files is now a few common
varients for the obviously different sub-families (coldfire,
68x328 and 68360).

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.10-uc0.patch.gz


Change log:

. import of linux-2.6.10                       <gerg@snapgear.com>
. rework head start code for m68knommu         <gerg@snapgear.com>
. auto-detect SDRAM size on most platforms     <gerg@snapgear.com>
. combine common 68x328 config code            <gerg@snapgear.com>
. remove duplicate M5275EVB entry in Kconfig   <gerg@snapgear.com>
. auto-generate m68knommu/entry.S offsets      <phdm@macqel.be>
. remove duplication with KTHREAD_SIZE         <phdm@macqel.be>
. fix stack alignment on trap return           <phdm@macqel.be>
. reduce code size in FEC ethernet driver      <phdm@macqel.be>
. export lib udelay symbold                    <gerg@snapgear.com>
. cleanup atomic and bitops macros             <phdm@macqel.be>
. remove unused io_hw_swap.h                   <domen@coderock.org>


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com

