Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUIAMQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUIAMQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUIAMQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:16:55 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:45105
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S266218AbUIAMQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:16:54 -0400
Message-Id: <s135cbc5.006@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Wed, 01 Sep 2004 14:17:23 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: question on i386 very early memory detection cleanup patch
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a particular reason why this patch changes the alignment of
cpu_gdt_table to be page rather than cache line aligned? This is
particulary strange to me because the alignment is guaranteed only for
the boot processor, but not for any of the APs; for the latter ones
there isn't even a string guarantee that the table would be cache line
aligned (which it really should be); the weak guarantee only is through
an appearant assumption of GDT_ENTRIES being a sufficiently large power
of two.

Thanks, Jan
