Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVA3Kye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVA3Kye (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 05:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVA3Kye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 05:54:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21397 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261389AbVA3Kyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 05:54:33 -0500
Date: Sun, 30 Jan 2005 10:54:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
Message-ID: <20050130105429.GA28300@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Paul Blazejowski <diffie@gmail.com>,
	linux-kernel@vger.kernel.org, Nathan Scott <nathans@sgi.com>
References: <9dda349205012923347bc6a456@mail.gmail.com> <20050129235653.1d9ba5a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129235653.1d9ba5a9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 11:56:53PM -0800, Andrew Morton wrote:
> bix:/home/akpm> grep EXPORT x
> CONFIG_XFS_EXPORT=y
> CONFIG_EXPORTFS=m
> 
> That isn't going to work.  Something like this, perhaps?

We want to avoid building xfs_export.o when CONFIG_EXPORTFS
isn't set.  CONFIG_XFS_EXPORT=y and CONFIG_EXPORTFS=m worked for
me in my testing.  Do you have XFS builtin or modular?

I suspect we need to add another weird depency to force XFS builtin
when NFSD is modular.

