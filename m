Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287158AbSBCNkj>; Sun, 3 Feb 2002 08:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287177AbSBCNk3>; Sun, 3 Feb 2002 08:40:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34824 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287158AbSBCNkU>;
	Sun, 3 Feb 2002 08:40:20 -0500
Date: Sun, 3 Feb 2002 14:39:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steffen Persvold <sp@scali.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
Message-ID: <20020203143946.H29553@suse.de>
In-Reply-To: <3C5D3BC9.CA9E24A@scali.com> <Pine.LNX.4.33.0202031632580.11943-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202031632580.11943-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03 2002, Ingo Molnar wrote:
> 
> On Sun, 3 Feb 2002, Steffen Persvold wrote:
> 
> > Can generic_make_request() be called from interrupt level (or tasklet)
> > ?
> 
> no.

In theory, READA from interrupt context would be ok, though. That
doesn't work in real-life due to the non flag saving spin locking in
__make_request.

-- 
Jens Axboe

