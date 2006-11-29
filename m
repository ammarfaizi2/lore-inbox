Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758781AbWK2IkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758781AbWK2IkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758804AbWK2IkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:40:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64492 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1758781AbWK2IkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:40:11 -0500
Date: Wed, 29 Nov 2006 08:40:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       aia21@cantab.net
Subject: Re: [PATCH 1/2] lib + ntfs: let modules force HWEIGHT
Message-ID: <20061129084009.GC12734@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
	aia21@cantab.net
References: <20061128140840.f87540e8.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128140840.f87540e8.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 02:08:40PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> NTFS (=m) uses hweight32(), but that function is only linked
> into the kernel image if it is used inside the kernel image,
> not in loadable modules.  Let modules force HWEIGHT to be
> built into the kernel image.  Otherwise build fails:
> 
>   Building modules, stage 2.
>   MODPOST 94 modules
> WARNING: "hweight32" [fs/ntfs/ntfs.ko] undefined!
> 
> Yes, I'd certainly prefer for this to be more automated rather than
> forced by each module that needs it.

Please just make it builtin-in always and remove it from lib-y.
Bonus points for killing of the lib-y braindamage entirely.

