Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVGDOq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVGDOq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 10:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVGDOq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 10:46:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47498 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261173AbVGDOpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 10:45:20 -0400
Date: Mon, 4 Jul 2005 16:46:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050704144634.GQ1444@suse.de>
References: <20050704061713.GA1444@suse.de> <20050704142723.2202.qmail@web88009.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704142723.2202.qmail@web88009.mail.re2.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't top post!)

On Mon, Jul 04 2005, Shawn Starr wrote:
> 
> We could put it in userspace, but if the system is
> swapping like mad, can we still get a critical
> response if this remains in userspace fully?

Just make sure the program isn't swapped out.

> Someone mentioned we should use a kernel thread(s) to
> handle stopping all I/O so we can safely park heads.

That's madness, we can't add a kernel thread for every single little
silly thing. You don't need to stop any io, you just want to make sure
that your park request gets issued right after the current io has
finished.


-- 
Jens Axboe

