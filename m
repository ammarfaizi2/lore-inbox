Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264909AbUGBT3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbUGBT3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264910AbUGBT3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:29:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41390 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264909AbUGBT3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:29:09 -0400
Date: Fri, 2 Jul 2004 14:29:06 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 PPC64 Power5 PCI boot fixes
Message-ID: <20040702142906.X21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul,

Please review and forward upstream the following PCI EEH patch.

This patch allows ppc64 to boot on the Power5 architecture.  The 
new Power5 PCI bridge design requires EEH to be enabled for all PCI
devices, not just some PCI devices.  In addition, this patch moves
the check for PCI to ISA bridges out of perf critical code, and into
initialization code.   This also avoids race conditions where the 
device type might not have been set.  Also, some whitespace fixes, 
and some error-message-printing beautification. 

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas
