Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVDYNSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVDYNSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 09:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVDYNSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 09:18:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50330 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262606AbVDYNSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 09:18:02 -0400
Date: Mon, 25 Apr 2005 14:17:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <roland@topspin.com>
Cc: Timur Tabi <timur.tabi@ammasso.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050425131753.GA8860@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <roland@topspin.com>,
	Timur Tabi <timur.tabi@ammasso.com>, Andrew Morton <akpm@osdl.org>,
	hozer@hozed.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com> <52is2bvvz5.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52is2bvvz5.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 06:15:10AM -0700, Roland Dreier wrote:
> Does it seem reasonable to add a new system call to let userspace mark
> memory it doesn't want copied into forked processes?  Something like
> 
> 	long sys_mark_nocopy(unsigned long addr, size_t len, int mark)
> 
> which would set VM_DONTCOPY if mark != 0, and clear it if mark == 0.
> A better name would be gratefully accepted...

add a new MAP_DONTCOPY flag and accept it in mmap and mprotect?

