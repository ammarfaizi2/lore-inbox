Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289792AbSAJXzM>; Thu, 10 Jan 2002 18:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289793AbSAJXzD>; Thu, 10 Jan 2002 18:55:03 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:23005 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289792AbSAJXyx>; Thu, 10 Jan 2002 18:54:53 -0500
Date: Thu, 10 Jan 2002 18:54:50 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagecache lock ordering
Message-ID: <20020110185450.G8433@redhat.com>
In-Reply-To: <3C3CE5D6.2204BD27@zip.com.au> <Pine.LNX.4.21.0201101332560.1121-100000@localhost.localdomain> <3C3DFBEF.BA050536@zip.com.au>, <3C3DFBEF.BA050536@zip.com.au>; <20020110182804.D8433@redhat.com> <3C3E2819.6A3AAD77@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C3E2819.6A3AAD77@zip.com.au>; from akpm@zip.com.au on Thu, Jan 10, 2002 at 03:47:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 03:47:37PM -0800, Andrew Morton wrote:
> You seem to be using writeout_one_page().  What I was
> thinking of was:
> 
> - Kill generic_buffer_fdatasync().
> - Move writeout_one_page() into fs/buffer.c
> - Move waitfor_one_page() into fs/buffer.c.  This is just
>   for completeness; I expect this function will have no
>   callers soon.  __iodesc_sync_wait_page() could use it though.
> 
> OK by you?

*shrug* it just makes my task of merging patches harder, that's all.

		-ben
-- 
Fish.
