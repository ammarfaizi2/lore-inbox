Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWGZTeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWGZTeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWGZTeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:34:46 -0400
Received: from mail.fieldses.org ([66.93.2.214]:19609 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751772AbWGZTep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:34:45 -0400
Date: Wed, 26 Jul 2006 15:34:42 -0400
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 006 of 9] knfsd: Remove nfsd_versbits as intermediate storage for desired versions.
Message-ID: <20060726193442.GF31172@fieldses.org>
References: <20060725114207.21779.patches@notabene> <1060725015452.21969@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060725015452.21969@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 11:54:52AM +1000, NeilBrown wrote:
> +int nfsd_vers(int vers, enum vers_op change)
> +{
> +	if (vers < NFSD_MINVERS || vers >= NFSD_NRVERS)
> +		return -1;

This isn't actually used; remove it or make it a BUG_ON()?

--b.
