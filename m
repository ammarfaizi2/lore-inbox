Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWBRMhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWBRMhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWBRMhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:37:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36800 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751203AbWBRMhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:37:25 -0500
Date: Sat, 18 Feb 2006 12:37:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: T?r?k Edwin <edwin@gurde.com>
Cc: Christoph Hellwig <hch@infradead.org>, netfilter-devel@lists.netfilter.org,
       fireflier-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       martinmaurer@gmx.at
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both incoming and outgoing packets
Message-ID: <20060218123720.GA1811@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	T?r?k Edwin <edwin@gurde.com>, netfilter-devel@lists.netfilter.org,
	fireflier-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	martinmaurer@gmx.at
References: <200602181410.59757.edwin.torok@level7.ro> <20060218122512.GG911@infradead.org> <200602181432.14483.edwin@gurde.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602181432.14483.edwin@gurde.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 02:32:14PM +0200, T?r?k Edwin wrote:
> Is there an alternative for locking the tasklist, and iterating through all 
> the threads to: find out the struct task*  given a struct fown_struct*. Or is 
> there any other way to find out the inode, and mountpoint of that process?

no, and a driver shouldn't do that.  This might sound harsh, but I'd say
what you're trying to do is fundamentally doomed ;-)

