Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWHWPaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWHWPaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWHWPaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:30:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6119 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964989AbWHWPaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:30:20 -0400
Date: Wed, 23 Aug 2006 16:29:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 9/18] 2.6.17.9 perfmon2 patch for review: kernel-level interface support
Message-ID: <20060823152959.GD32725@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Eranian <eranian@frankl.hpl.hp.com>,
	linux-kernel@vger.kernel.org, eranian@hpl.hp.com
References: <200608230806.k7N860es000444@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608230806.k7N860es000444@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 01:06:00AM -0700, Stephane Eranian wrote:
> This patch contains the kernel-level API support.
> 
> 
> Some users have requested the ability to create a monitoring session
> with perfmon2 from iside the kernel using a kernel thread. Perfmon2
> leverages a lot of kernel mechanisms which are not easy to use for
> inside the kernel: e.g. file descriptor, signals, system calls.

Again, please drop this.  There are no planned intree kernel users
so far, and once we add them we can architect a proper API for them.
Getting rid of this should also help to collapse the tons of useless
abstractions layers in the current perfmon code.

