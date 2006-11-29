Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967485AbWK2RJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967485AbWK2RJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 12:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967487AbWK2RJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 12:09:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59313 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S967485AbWK2RJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 12:09:41 -0500
Date: Wed, 29 Nov 2006 17:09:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] i386 add idle notifier
Message-ID: <20061129170939.GA29203@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Eranian <eranian@hpl.hp.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, ak@suse.de
References: <20061129162540.GL28007@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129162540.GL28007@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 08:25:40AM -0800, Stephane Eranian wrote:
> Hello,
> 
> Here is a patch that adds an idle notifier to the i386 tree.
> The idle notifier functionalities and implementation are
> identical to the x86_64 idle notifier. We use the idle notifier
> in the context of perfmon.
> 
> The patch is against Andi Kleen's x86_64-2.6.19-rc6-061128-1.bz2
> kernel. It may apply to other kernels but it needs some updates
> to poll_idle() and default_idle() to work correctly.

Walking through a notifier chain on every single interrupt (including
timer interrupts) seems rather costly.  What do you need this for
exactly?

