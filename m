Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbUDASNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUDASNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:13:05 -0500
Received: from holomorphy.com ([207.189.100.168]:57774 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263012AbUDASNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:13:01 -0500
Date: Thu, 1 Apr 2004 10:12:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       kenneth.w.chen@intel.com, Chris Wright <chrisw@osdl.org>
Subject: Re: disable-cap-mlock
Message-ID: <20040401181256.GJ791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
	Chris Wright <chrisw@osdl.org>
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random> <20040401171625.GE791@holomorphy.com> <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil> <20040401174405.GG791@holomorphy.com> <20040401175114.GH791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401175114.GH791@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 09:44:05AM -0800, William Lee Irwin III wrote:
>> I'm aware it does some very unintelligent things to the security model,
>> e.g. anyone with fs-level access to these things can basically escalate
>> their capabilities to "everything". Maybe some kind of big fat warning
>> is in order.

And maybe proper directory permissions, too.

Index: mm4-2.6.5-rc3/security/sysctl_capable.c
===================================================================
--- mm4-2.6.5-rc3.orig/security/sysctl_capable.c	2004-04-01 09:41:41.000000000 -0800
+++ mm4-2.6.5-rc3/security/sysctl_capable.c	2004-04-01 10:11:53.000000000 -0800
@@ -111,7 +111,7 @@
 	{
 		.ctl_name	= CTL_KERN,
 		.procname	= "capability",
-		.mode		= 0644,
+		.mode		= 0555,
 		.child		= capability_sysctl_table,
 	},
 	{
