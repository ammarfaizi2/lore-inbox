Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWA3RTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWA3RTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWA3RTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:19:48 -0500
Received: from gold.veritas.com ([143.127.12.110]:61332 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964815AbWA3RTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:19:47 -0500
Date: Mon, 30 Jan 2006 17:20:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>, hch@lst.de
Subject: Re: [PATCH] generic_file_write_nolock cleanup
In-Reply-To: <1138640165.28382.3.camel@dyn9047017102.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0601301717060.5478@goblin.wat.veritas.com>
References: <1138640165.28382.3.camel@dyn9047017102.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Jan 2006 17:19:46.0823 (UTC) FILETIME=[5E55B970:01C625C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006, Badari Pulavarty wrote:
> 
> generic_file_write_nolock() and __generic_file_write_nolock() seems
> to be doing exactly same thing. Why do we have 2 of these ? 
> Can we kill __generic_file_write_nolock() ?

Doesn't generic_file_write_nolock() call generic_file_aio_write_nolock(),
but __generic_file_write_nolock() call __generic_file_aio_write_nolock()?
With the first doing some syncing which the __second doesn't do?

Lovely names in mm/filemap.c, aren't they?

Hugh
