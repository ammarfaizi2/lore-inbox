Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318762AbSIKNIS>; Wed, 11 Sep 2002 09:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318765AbSIKNIS>; Wed, 11 Sep 2002 09:08:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46501 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318762AbSIKNIS>;
	Wed, 11 Sep 2002 09:08:18 -0400
Date: Wed, 11 Sep 2002 15:13:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
Message-ID: <20020911131300.GN1089@suse.de>
References: <15743.15275.412038.388540@argo.ozlabs.ibm.com> <20020911130209.GL1089@suse.de> <20020911130754.GM1089@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911130754.GM1089@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Jens Axboe wrote:
> On Wed, Sep 11 2002, Jens Axboe wrote:
> > Also, can you grow sg segments indefinitely?
> 
> Maybe you copied that from ide-dma? I think it would be safer to just
> remove it, btw, there's no (if any) benefit to making the sg segments
> bigger than a page since we'll much sooner hit the max sectors
> limitation than the segment one.

ide_build_dmatable() makes sure that it is safe, so no extra checking is
needed. So we can keep current behaviour and its not a bug and no
changes are needed in either ide-dma nor ide-pmac.

-- 
Jens Axboe

