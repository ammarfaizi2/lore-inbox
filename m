Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136702AbRAHEGx>; Sun, 7 Jan 2001 23:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136708AbRAHEGo>; Sun, 7 Jan 2001 23:06:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27920 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136702AbRAHEGe>;
	Sun, 7 Jan 2001 23:06:34 -0500
Date: Mon, 8 Jan 2001 05:06:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "John O'Donnell" <johnod@voicefx.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0:  __alloc_pages: 3-order allocation failed.
Message-ID: <20010108050612.A2519@suse.de>
In-Reply-To: <3A58E69D.30005@voicefx.com> <Pine.LNX.4.21.0101072006450.21675-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101072006450.21675-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sun, Jan 07, 2001 at 08:07:52PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07 2001, Rik van Riel wrote:
> > __alloc_pages: 3-order allocation failed.
> 
> This debugging check should probably be removed around
> 2.4.5, in the mean time it is much too useful to track
> down badly behaving device drivers ;)

It need not be a badly written driver, it could be a fine one
just trying to see if it can get 2^3 successive pages for
performance reasons. As long as it continues on its merry way when
this fails it would be fine, and this message just confuses users.

Plus, for this to be really useful as a catch-bad-guys tool it
would be nice with a hint as what causes it (EIP or even a
call trace).

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
