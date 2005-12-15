Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVLOOxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVLOOxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVLOOxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:53:05 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:21674
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750703AbVLOOxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:53:04 -0500
Message-Id: <43A19190.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 15 Dec 2005 15:53:52 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: pte_alloc_kernel parameters
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any particular reason why pte_alloc_kernel() has to have
'struct mm_struct*' as its first parameter? Except for a case in parisc
(where NULL gets passed) and another (ill-looking one) in arm26 it is
always &init_mm, and since the function is not inline the compiler can't
eliminate the needless passing of the argument.

Thanks, Jan
