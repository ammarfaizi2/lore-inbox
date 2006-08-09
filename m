Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWHIRJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWHIRJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWHIRJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:09:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8422 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750736AbWHIRJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:09:08 -0400
Date: Wed, 9 Aug 2006 18:09:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 1/6] prepare for write access checks: collapse if()
Message-ID: <20060809170904.GA7324@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060809165729.FE36B262@localhost.localdomain> <20060809165730.0F7D9814@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809165730.0F7D9814@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 09:57:30AM -0700, Dave Hansen wrote:
> 
> We're shortly going to be adding a bunch more permission
> checks in these functions.  That requires adding either a
> bunch of new if() conditions, or some gotos.  This patch
> collapses existing if()s and uses gotos instead to
> prepare for the upcoming changes.
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>


Acked-by: Christoph Hellwig <hch@lst.de>

> +	res = vfs_permission(&nd, mode);
> +	/* SuS v2 requires we report a read only fs too */
> +	if(res || !(mode & S_IWOTH) ||

except that there's a space missing after the if here :)

