Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVCTJlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVCTJlC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 04:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVCTJlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 04:41:02 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56801 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262055AbVCTJkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 04:40:55 -0500
Date: Sun, 20 Mar 2005 09:40:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matt Dainty <matt@bodgit-n-scarper.com>
Cc: linux-kernel@vger.kernel.org, Erich Chen <erich@areca.com.tw>
Subject: Re: Building Areca arcmsr driver outside kernel source tree
Message-ID: <20050320094052.GA12363@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Dainty <matt@bodgit-n-scarper.com>,
	linux-kernel@vger.kernel.org, Erich Chen <erich@areca.com.tw>
References: <1111258047.3746.45.camel@lister.bodgit-n-scarper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111258047.3746.45.camel@lister.bodgit-n-scarper.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 06:47:27PM +0000, Matt Dainty wrote:
> To get the arcmsr driver working with CentOS/RHEL 4 and using the
> facility to build kernel modules outside of the kernel source tree, I
> found the attached patch was necessary to remove the dependencies on the
> internal drivers/scsi/scsi*.h header files and to instead use the public
> ones found under include/scsi/ which are provided by the kernel-*-devel
> packages.
> 
> It builds, loads and appears to work with my limited testing on an
> ARC1120. I was just wanting to know if this was the right way to fix it?
> Once the driver is in the main kernel tree it's largely irrelevant, but
> while CentOS/RHEL 4 use the older kernel without the driver it's a PITA
> to maintain kernel packages with this one driver added, when a separate
> package containing just the driver is much easier.
> 
> The patch is based on the 1.20.00.06 driver that was added to
> 2.6.11-mm4.

Patch looks good, scsi.h is deprecated for a long time and I told
Erich to stop using it already.

