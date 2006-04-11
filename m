Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWDKCnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWDKCnO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 22:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWDKCnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 22:43:14 -0400
Received: from mx1.suse.de ([195.135.220.2]:34025 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932251AbWDKCnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 22:43:14 -0400
From: Andi Kleen <ak@suse.de>
To: prasanna@in.ibm.com
Subject: Re: [PATCH] [2/5] Switch Kprobes inline functions to __kprobes for x86_64
Date: Tue, 11 Apr 2006 04:41:59 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       ananth@in.ibm.com, anil.s.keshavamurthy@intel.com,
       systemtap@sources.redhat.com
References: <20060410055712.GA24711@in.ibm.com> <20060410055813.GA23879@in.ibm.com>
In-Reply-To: <20060410055813.GA23879@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604110442.00259.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 April 2006 07:58, Prasanna S Panchamukhi wrote:
> Andrew Morton pointed out that compiler might not inline the functions
> marked for inline in kprobes. There by allowing the insertion of probes
> on these kprobes routines, which might cause recursion. This patch
> removes all such inline and adds them to kprobes section there by
> disallowing probes on all such routines. Some of the routines can
> even still be inlined, since these routines gets executed after
> the kprobes had done necessay setup for reentrancy.

Ok for me.

-Andi
