Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWA3SH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWA3SH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWA3SH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:07:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:34998 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964861AbWA3SH5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:07:57 -0500
Subject: Re: [PATCH] generic_file_write_nolock cleanup
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>, hch@lst.de
In-Reply-To: <Pine.LNX.4.61.0601301717060.5478@goblin.wat.veritas.com>
References: <1138640165.28382.3.camel@dyn9047017102.beaverton.ibm.com>
	 <Pine.LNX.4.61.0601301717060.5478@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 10:07:27 -0800
Message-Id: <1138644447.28382.10.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 17:20 +0000, Hugh Dickins wrote:
> On Mon, 30 Jan 2006, Badari Pulavarty wrote:
> > 
> > generic_file_write_nolock() and __generic_file_write_nolock() seems
> > to be doing exactly same thing. Why do we have 2 of these ? 
> > Can we kill __generic_file_write_nolock() ?
> 
> Doesn't generic_file_write_nolock() call generic_file_aio_write_nolock(),
> but __generic_file_write_nolock() call __generic_file_aio_write_nolock()?
> With the first doing some syncing which the __second doesn't do?
> 
> Lovely names in mm/filemap.c, aren't they?

Sigh !! I see it now. It was my version which was exactly equal (I was
doing some cleanup). :(

Please ignore my patch.

Thanks,
Badari

