Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318772AbSIKM5p>; Wed, 11 Sep 2002 08:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318775AbSIKM5p>; Wed, 11 Sep 2002 08:57:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46500 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318772AbSIKM5o>;
	Wed, 11 Sep 2002 08:57:44 -0400
Date: Wed, 11 Sep 2002 15:02:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
Message-ID: <20020911130209.GL1089@suse.de>
References: <15743.15275.412038.388540@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15743.15275.412038.388540@argo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Paul Mackerras wrote:
> Marcelo,
> 
> This patch fixes drivers/ide/ide-pmac.c to handle I/O to highmem
> pages.  Please apply it to your tree.

Doesn't look like it's needed at all, at least you never turn on highmem
I/O with ide_toggle_bounce() :-)

BTW, it would be ok to export that from ide-dma.c instead of duplicating
it in ide-pmac.

Also, can you grow sg segments indefinitely?

-- 
Jens Axboe

