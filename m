Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWCaJ5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWCaJ5P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 04:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWCaJ5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 04:57:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30304 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751306AbWCaJ5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 04:57:14 -0500
Date: Fri, 31 Mar 2006 11:57:14 +0200
From: Jens Axboe <axboe@suse.de>
To: tridge@samba.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] splice support #2
Message-ID: <20060331095711.GK14022@suse.de>
References: <17452.50912.404106.256236@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17452.50912.404106.256236@samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31 2006, tridge@samba.org wrote:
> Linus and Jens,
> 
> Stephen Rothwell just pointed me at the new splice() interface. Looks
> really nice!
> 
> One comment though. Could we add a off_t to splice to make it more
> like pwrite() ? Otherwise threads could get painful with race
> conditions between the seek and the splice() call.
> 
> Either that or add psplice() like this:
> 
>   ssize_t psplice(int fdin, int fdout, size_t len, off_t ofs, unsigned flags);
> 
> where ofs sets the offset to read from fdin. 

I definitely see some valid reasons for adding a file offset instead of
using ->f_pos, I'll leave that decision up to Linus though. Linus?

-- 
Jens Axboe

