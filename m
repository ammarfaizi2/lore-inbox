Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWHGNWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWHGNWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWHGNWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:22:22 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:21302
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932077AbWHGNWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:22:21 -0400
Message-Id: <44D75ACE.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 07 Aug 2006 14:22:54 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: <anil.s.keshavamurthy@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: notify_page_fault_chain
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I just noticed this addition to i386 and x86-64, conditionalized upon CONFIG_KPROBES. May I ask what the motivation for
this compatibility breaking change is? Only performance? I consider it already questionable to split out a specific
fault from the general die notification (previous users of the functionality all of the sudden won't get notifications
for one of the most crucial faults anymore), but entirely hiding the functionality (unavailable without CONFIG_KPROBES,
and even with it not getting exported) is really odd.

Thanks for any clarification,
Jan
