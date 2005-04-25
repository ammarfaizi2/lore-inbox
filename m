Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVDYOQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVDYOQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 10:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVDYOQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 10:16:30 -0400
Received: from webmail.houseafrika.com ([12.162.17.52]:14665 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S262615AbVDYOQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 10:16:28 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, Andrew Morton <akpm@osdl.org>,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com> <20050425131753.GA8860@infradead.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 25 Apr 2005 07:16:23 -0700
In-Reply-To: <20050425131753.GA8860@infradead.org> (Christoph Hellwig's
 message of "Mon, 25 Apr 2005 14:17:53 +0100")
Message-ID: <523btfvt54.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Apr 2005 14:16:23.0555 (UTC) FILETIME=[5C364530:01C549A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> Does it seem reasonable to add a new system call to let
    Roland> userspace mark memory it doesn't want copied into forked
    Roland> processes?  Something like

    Roland> long sys_mark_nocopy(unsigned long addr, size_t len, int
    Roland> mark)

    Roland> which would set VM_DONTCOPY if mark != 0, and clear it if
    Roland> mark == 0.  A better name would be gratefully accepted...

    Christoph> add a new MAP_DONTCOPY flag and accept it in mmap and
    Christoph> mprotect?

That is much better, thanks.  But I think it would need to be
PROT_DONTCOPY to work with mprotect(), right?

 - R.

