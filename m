Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVK0Bqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVK0Bqe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 20:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVK0Bqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 20:46:34 -0500
Received: from eastrmmtao05.cox.net ([68.230.240.34]:36326 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750814AbVK0Bqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 20:46:33 -0500
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <44E57FC6-A500-42B7-86F9-F1F4E72734EC@mac.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andy Whitcroft <apw@shadowen.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [2.6.15-rc2-mm1] Disabled flatmem on ppc32? (ARCH=powerpc)
Date: Sat, 26 Nov 2005 20:46:31 -0500
To: LKML Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a Kconfig problem for ppc32 in the latest -mm kernel.  It  
seems that somehow the Kconfig logic for selecting memory models  
under ARCH=powerpc doesn't quite get it right for standard flatmem  
ppc32 systems.  When I look at the memory model selection, I only see  
sparsemem, whereas on a normal -rc2 kernel, I can see both flatmem  
and sparsemem.  This somehow triggers a #error where the number of  
reserved bits is less than the number necessary for the sparsemem  
layout (because we're on a 32-bit arch without the address space for  
sparsemem?).

Cheers,
Kyle Moffett

