Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWEIJgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWEIJgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWEIJgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:36:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26283 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751591AbWEIJgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:36:16 -0400
Date: Tue, 9 May 2006 10:36:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
Message-ID: <20060509093614.GB26953@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, suparna@in.ibm.com,
	richardj_moore@uk.ibm.com
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com> <20060509070106.GB22493@in.ibm.com> <20060509070508.GC22493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509070508.GC22493@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:35:08PM +0530, Prasanna S Panchamukhi wrote:
> This patch provides two interfaces to insert and remove
> user space probes. Each probe is uniquely identified by
> inode and offset within that executable/library file.
> Insertion of a probe involves getting the code page for
> a given offset, mapping it into the memory and then inserting
> the breakpoint at the given offset. Also the probe is added
> to the uprobe_table hash list. A uprobe_module data structure
> is allocated for every probed application/library image on disk.
> Removal of a probe involves getting the code page for a given
> offset, mapping that page into the memory and then replacing
> the breakpoint instruction with a the original opcode.
> This patch also provides aggregate probe handler feature,
> where user can define multiple handlers per probe.

This introduces interfaces that aren't used anywhere in the following
patches.  That is completely not acceptable.  Please provide a proper
userspace interface to this functionality, e.g. something based on the
RPN code from Richard's dprobes.

