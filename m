Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUKCLg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUKCLg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 06:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbUKCLg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 06:36:56 -0500
Received: from 252.5.3.213.fix.bluewin.ch ([213.3.5.252]:65386 "EHLO elonex.ch")
	by vger.kernel.org with ESMTP id S261497AbUKCLgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 06:36:54 -0500
Subject: 2.4 lockup issue (flush_tlb_all)
From: Thomas Oulevey <thomas.oulevey@elonex.ch>
Reply-To: thomas.oulevey@elonex.ch
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Elonex Switzerland
Date: Wed, 03 Nov 2004 12:36:47 +0100
Message-Id: <1099481807.4714.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are experiencing some lockup problems with our SMP configuration. 
Here are the details :
- The computers lockup with no relevant logs.
- The kernel still replies to ping but higher level services are not
responding.
- After few hours (5-8), the kernel answers again and the load is around
40 then decreasing. 

We manage to get some SysRq showPc output (screenshot :
http://www.elonex.ch/shot/)
According to the basic sysreq debugging, the problem seems to be related
to the function flush_tlb_all, and it is triggered with a write or read
(local or on nfs sometimes).

I looked at the LKML, and didn't find any known issues.
Maybe it has been corrected but not backported by redhat ! 
I'll appreciate any help.

Thank you in advance.

detailed configuration :
---------------
Processor   : 2 x 2.8Ghz Pentium Xeon
Motherboard : Intel se7501cw2
Memory      : 4 x 512MB DDR 266 ECC registered
Kernel      : 2.4.20-31 (Redhat 7.3 with updates)


PLEASE CC the answers/comments

-- 
Thomas OULEVEY System Engineer
Elonex Switzerland      Email: thomas.oulevey@elonex.ch
Switzerland

