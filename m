Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbTCGN7m>; Fri, 7 Mar 2003 08:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbTCGN7m>; Fri, 7 Mar 2003 08:59:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34445 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261585AbTCGN7l>;
	Fri, 7 Mar 2003 08:59:41 -0500
Date: Fri, 7 Mar 2003 16:08:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Subodh S <subodh_s_1975@mail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: About dd & make_request
Message-ID: <20030307150809.GH941@suse.de>
References: <20030307140502.95076.qmail@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307140502.95076.qmail@mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07 2003, Subodh S wrote:
> Hi,
> 
> When run
> 
> dd if=/dev/mydevice of=/dev/null count=10
> 
> why does my make_request function get called only five times ??

because you didn't change the block size, so you got 5 1024b (default)
buffers thrown at you?

-- 
Jens Axboe

