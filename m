Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVHaW1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVHaW1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVHaW1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:27:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31137
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964949AbVHaW1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:27:41 -0400
Date: Wed, 31 Aug 2005 15:27:37 -0700 (PDT)
Message-Id: <20050831.152737.107306011.davem@davemloft.net>
To: jkenisto@us.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ppancham@in.ibm.com,
       systemtap@sources.redhat.com
Subject: Re: [PATCH] Fix kprobes handling of simultaneous probe
 hit/unregister
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1125525217.2855.35.camel@localhost.localdomain>
References: <1125525217.2855.35.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Keniston <jkenisto@us.ibm.com>
Date: 31 Aug 2005 14:53:37 -0700

> This bug doesn't exist on ppc64 and ia64, where a breakpoint
> instruction leaves the IP pointing to the beginning of the instruction.
> I don't know about sparc64.  (Dave, could you please advise?)

On sparc64 instructions are all 32-bit, 4-byte aligned, and a
breakpoint instruction leaves the PC pointing at the beginning of that
breakpoint instruction.

So I think sparc64 should be OK.
