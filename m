Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263290AbUJ2MCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbUJ2MCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbUJ2MCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:02:00 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:47108 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263294AbUJ2MAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 08:00:33 -0400
Date: Fri, 29 Oct 2004 13:00:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH[ Export __PAGE_KERNEL_EXEC for modules (vmmon)
Message-ID: <20041029120031.GD11391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, mingo@redhat.com,
	linux-kernel@vger.kernel.org
References: <20041028221148.GE24972@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028221148.GE24972@vana.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 12:11:48AM +0200, Petr Vandrovec wrote:
> Hello Ingo,
>   recently support for NX on i386 arrived to 2.6.x kernel, and I have
> some problems building code which uses vmap since then - PAGE_KERNEL_EXEC
> expands to __PAGE_KERNEL_EXEC, and this one is not accessible to modules.

The right thing is not to mark kernel virtual memory executable from
modules at all.

