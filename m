Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262619AbTCRWS1>; Tue, 18 Mar 2003 17:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbTCRWS1>; Tue, 18 Mar 2003 17:18:27 -0500
Received: from havoc.daloft.com ([64.213.145.173]:10930 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262619AbTCRWS0>;
	Tue, 18 Mar 2003 17:18:26 -0500
Date: Tue, 18 Mar 2003 17:29:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dev_t [1/3]
Message-ID: <20030318222918.GD23134@gtf.org>
References: <UTC200303182145.h2ILjEB29313.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303182145.h2ILjEB29313.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 10:45:14PM +0100, Andries.Brouwer@cwi.nl wrote:
> The first patch is the cdev-kill patch that I sent out
> earlier. It is no use having two forms of chardev registration
> in the source, and my version of the path of small modifications
> does not pass through this version, although the final result
> will not be that different. So, kill cdev_cachep, cdev_cache_init,
> cdfind, cdget, cdput, inode->i_cdev, struct char_device.
> All of this is dead code today.

You're also removing refcount code... why not fix it up instead?

I agree your patch is mostly correct from a "today" standpoint, but from
a long term standpoint I think fixing up the code as intended would be
the best path.  It would be silly to remove this code only to add it
again.

	Jeff



