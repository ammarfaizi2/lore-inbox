Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbULPQ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbULPQ47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbULPQ4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:56:36 -0500
Received: from [213.146.154.40] ([213.146.154.40]:13758 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261744AbULPQ4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:56:06 -0500
Date: Thu, 16 Dec 2004 16:56:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
Message-ID: <20041216165602.GA10560@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, willy@debian.org
References: <200412160850.20223.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412160850.20223.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 08:50:19AM -0800, Jesse Barnes wrote:
> This patch documents the /proc/bus/pci interface and adds some optional 
> architecture specific APIs for accessing legacy I/O port and memory space.  
> This is necessary on platforms where legacy I/O port space doesn't 'soft 
> fail' like it does on PCs, and is useful for systems that can route legacy 
> space to different PCI busses.

Please don't add more interfaces to procfs.  And ioctl() on procfs is even
more evil.

