Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVHANTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVHANTD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 09:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVHANTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 09:19:02 -0400
Received: from mail.emacinc.com ([208.248.202.76]:56207 "EHLO mail.emacinc.com")
	by vger.kernel.org with ESMTP id S262111AbVHANS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 09:18:57 -0400
From: NZG <ngustavson@emacinc.com>
Organization: EMAC.Inc
To: comedi@comedi.org
Date: Mon, 1 Aug 2005 08:17:59 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508010817.59676.ngustavson@emacinc.com>
X-SA-Exim-Connect-IP: 208.248.202.77
X-SA-Exim-Mail-From: ngustavson@emacinc.com
Subject: 2.6VMM, uClinux, & Comedi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Relay: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to successfully cross-compile Comedi for the Coldfire uClinux 2.6, 
however it has several unresolved symbols when I try to load it.

comedi: Unknown symbol pgd_offset_k
comedi: Unknown symbol pmd_none
comedi: Unknown symbol remap_page_range
comedi: Unknown symbol pte_present
comedi: Unknown symbol pte_offset_kernel
comedi: Unknown symbol VMALLOC_VMADDR
comedi: Unknown symbol pte_page

Apparently uClinux isn't implementing these paged memory functions,which
kind of makes sense, but I'm a little fuzzy on what the nommu code is
supposed to be doing exactly, and I couldn't find any documentation on what 
these functions are doing in the vanilla 2.6 kernel.
Has anyone else been down this road before?
I found Mel Gorman's Thesis on the 2.4 mm functions, but I couldn't find most 
of these symbols in it.
It's looking like the 2.6 mm stuff is still pretty undocumented, any links to 
documentation (or short text explanations)would be appreciated. 

thx.
NZG.
