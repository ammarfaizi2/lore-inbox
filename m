Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbULVS10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbULVS10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbULVS10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:27:26 -0500
Received: from [213.146.154.40] ([213.146.154.40]:43959 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262012AbULVS0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:26:07 -0500
Date: Wed, 22 Dec 2004 18:26:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joerg Sommrey <jo175@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.6.9-ac16: xfs, dm and md may be involved
Message-ID: <20041222182606.GA14733@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joerg Sommrey <jo175@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041221185754.GA28356@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221185754.GA28356@sommrey.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 07:57:54PM +0100, Joerg Sommrey wrote:
> Hello,
> 
> last night my box died with a kernel oops.  There was a backup
> running at that time. The setup:
> - 2 SATA disks + 1 SCSI disk
> - SATA partitions build up md-raid-arrays (level 0 and 1)
> - md-raid-devices and SCSI partitions are physical volumes for dm
> - dm logical volumes are used for xfs filesystems
> - backup is done on dm-snapshots of those filesystems

Given the strange backtrace and this enormous stack of drivers I bet
you're seeing a stack overflow.  

