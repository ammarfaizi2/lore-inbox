Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWEIJi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWEIJi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWEIJi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:38:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29099 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751721AbWEIJi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:38:29 -0400
Date: Tue, 9 May 2006 10:38:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: [RFC] [PATCH 5/6] Kprobes: Single step the original instruction out-of-line
Message-ID: <20060509093827.GD26953@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>,
	linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
	akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
	suparna@in.ibm.com, richardj_moore@uk.ibm.com
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com> <20060509070106.GB22493@in.ibm.com> <20060509070508.GC22493@in.ibm.com> <20060509070911.GD22493@in.ibm.com> <20060509071204.GE22493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509071204.GE22493@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:42:04PM +0530, Prasanna S Panchamukhi wrote:
> Even if the vma cannot be extended, then the instruction much be
> executed inline, by replacing the breakpoint instruction with the
> original instruction.

Patching pagecache content is not acceptable.  Just fail the probe
in this case.

