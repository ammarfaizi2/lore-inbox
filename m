Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWHIRKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWHIRKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWHIRKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:10:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20951 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750876AbWHIRKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:10:02 -0400
Date: Wed, 9 Aug 2006 18:09:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 2/6] r/o bind mount prepwork: move open_namei()'s vfs_create()
Message-ID: <20060809170958.GB7324@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060809165729.FE36B262@localhost.localdomain> <20060809165731.20FD1397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809165731.20FD1397@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 09:57:31AM -0700, Dave Hansen wrote:
> 
> The code around vfs_create() in open_namei() is getting a
> bit too complex.  Right now, there is at least the reference
> count on the dentry, and the i_mutex to worry about.  Soon,
> we'll also have mnt_writecount.
> 
> So, break the vfs_create() call out of open_namei(), and
> into a helper function.  This duplicates the call to
> may_open(), but that isn't such a bad thing since the
> arguments (acc_mode and flag) were being heavily massaged
> anyway.
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

Acked-by: Christoph Hellwig <hch@lst.de>

