Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUEAWPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUEAWPO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUEAWPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:15:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:50919 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262389AbUEAWPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:15:10 -0400
Date: Sat, 1 May 2004 15:14:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-Id: <20040501151424.2f22996b.akpm@osdl.org>
In-Reply-To: <20040501201342.GL2541@fs.tum.de>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> Please _undo_ the patch below.
> 
>  cu
>  Adrian
> 
>  --- a/drivers/media/dvb/frontends/tda1004x.c	Tue Apr 27 18:37:15 2004
>  +++ b/drivers/media/dvb/frontends/tda1004x.c	Tue Apr 27 18:37:15 2004
>  @@ -188,7 +190,6 @@
>   static struct fwinfo tda10046h_fwinfo[] = { {.file_size = 286720,.fw_offset = 0x3c4f9,.fw_size = 24479} };
>   static int tda10046h_fwinfo_count = sizeof(tda10046h_fwinfo) / sizeof(struct fwinfo);
>   
>  -static int errno;

Would be better to export sys_open() and sys_lseek() to GPL modules rather
than persisting with this cruft.

This driver was going to be converted to use the firmware loader API?
