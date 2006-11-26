Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935341AbWKZMJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935341AbWKZMJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 07:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935342AbWKZMJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 07:09:16 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:19466 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S935341AbWKZMJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 07:09:16 -0500
Message-ID: <456983E2.2060007@highlandsun.com>
Date: Sun, 26 Nov 2006 04:09:06 -0800
From: Howard Chu <hyc@highlandsun.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20061116 Netscape/7.2 (ax) Firefox/1.5 SeaMonkey/1.5a
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: skge error; hangs w/ hardware memory hole (was re: X86_64 + VIA
 + 4g problems)
References: <S935347AbWKZLoQ/20061126114416Z+54@vger.kernel.org>
In-Reply-To: <S935347AbWKZLoQ/20061126114416Z+54@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060703205238.GA10851@deprecation.cyrius.com> 
<p73bqyufo97.fsf@verdi.suse.de>

Just to tie up a loose end... I tested Andi Kleen's new patch for this 
issue on 2.6.18.3. While the patch didn't automatically detect the VIA 
chipset in my Asus A8V Deluxe, it allowed me to manually set a boot 
option that fixes the problem (by disabling DMA to addresses over 4GB). 
The fix is essentially the same as Andi posted here

http://groups.google.com/group/linux.kernel/msg/b1e820ef0212ee5e

although you have to patch pci-dma.c now, not pci-gart.c.

As another note - with my AGP aperture set to only 64MB, 3904MB are 
visible. With the aperture set to 256MB, the full 4096MB are visible.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

