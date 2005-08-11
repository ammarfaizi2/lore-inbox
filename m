Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVHKRdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVHKRdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVHKRdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:33:12 -0400
Received: from verein.lst.de ([213.95.11.210]:10714 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932301AbVHKRdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:33:11 -0400
Date: Thu, 11 Aug 2005 19:33:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050811173305.GA10372@lst.de>
References: <20050810080057.GA5295@lst.de> <20050811173203.GA31610@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811173203.GA31610@twiddle.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 10:32:03AM -0700, Richard Henderson wrote:
> On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:
> > The sys_ptrace boilerplate code (everything outside the big switch
> > statement for the arch-specific requests) is shared by most
> > architectures.  This patch moves it to kernel/ptrace.c and leaves the
> > arch-specific code as arch_ptrace.
> 
> The signature of arch_ptrace needs to return long, and not int.
> The PTRACE_PEEK{TEXT,DATA,USR} requests return a "word", which 
> on 64-bit arches needs to be a 64-bit type.

Ok.  Will be that way in the next patch.

