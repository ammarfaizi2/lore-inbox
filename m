Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270301AbTGMRC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270302AbTGMRC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 13:02:26 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:46853 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270301AbTGMRCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 13:02:24 -0400
Date: Sun, 13 Jul 2003 13:16:26 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Shane Shrybman <shrybman@sympatico.ca>
cc: Paul.Clements@steeleye.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nbd.c compile warning
In-Reply-To: <1058021412.10870.13.camel@mars.goatskin.org>
Message-ID: <Pine.LNX.4.10.10307131314500.764-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jul 2003, Shane Shrybman wrote:

> Here is a patch to fix a compile warning from nbd.c. It has been compile
> tested, ( I don't actually use nbd, yet). I have included the patch as
> an attachment in case it gets mangled.
> 
> --- linux-2.5.75-mm1/drivers/block/nbd.c.orig   Sat Jul 12 09:23:45 2003
> +++ linux-2.5.75-mm1/drivers/block/nbd.c        Sat Jul 12 09:45:06 2003
> @@ -261,7 +261,7 @@
>         dprintk(DBG_TX, "%s: request %p: sending control
> (%s@%llu,%luB)\n",
>                         lo->disk->disk_name, req,
>                         nbdcmd_to_ascii(nbd_cmd(req)),
> -                       req->sector << 9, req->nr_sectors << 9);
> +                       (unsigned long long)req->sector << 9,
> req->nr_sectors << 9);
>         result = sock_xmit(sock, 1, &request, sizeof(request),
>                         (nbd_cmd(req) == NBD_CMD_WRITE)? MSG_MORE: 0);
>         if (result <= 0) {
> 

Thanks, I'll send a patch on to Andrew Morton shortly.

--
Paul

