Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWHHQ0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWHHQ0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWHHQ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:26:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12237 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964962AbWHHQ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:26:03 -0400
Date: Tue, 8 Aug 2006 17:25:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [PATCH 2/3] Kprobes: Define retval helper
Message-ID: <20060808162559.GB28647@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	linux-kernel@vger.kernel.org,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Jim Keniston <jkenisto@us.ibm.com>
References: <20060807115537.GA15253@in.ibm.com> <20060807120024.GD15253@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807120024.GD15253@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 05:30:24PM +0530, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> Add the KPROBE_RETVAL macro to help extract the return value on
> different architectures, while using function-return probes.

Good idea.  You should add parentheses around regs, otherwise the C
preprocessor might bite users.  Also the shouting name is quite ugly.
In fact it should probably go to asm/system.h or similar and not have
a kprobes name - it just extracts the return value from a struct pt_regs
after all.

