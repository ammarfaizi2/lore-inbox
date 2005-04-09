Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVDIIrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVDIIrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 04:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVDIIrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 04:47:21 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:58384 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261156AbVDIIrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 04:47:17 -0400
Date: Sat, 9 Apr 2005 10:47:50 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>
Cc: samba@samba.org, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] fs/smbfs/request.c: turn NULL dereference into
 BUG()
Message-Id: <20050409104750.622b8f51.khali@linux-fr.org>
In-Reply-To: <20050326131132.GB3237@stusta.de>
References: <20050325001540.GF3966@stusta.de>
	<20050326100253.3edbb2fc.khali@linux-fr.org>
	<20050326125301.GA3237@stusta.de>
	<20050326131132.GB3237@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, all,

> In a case documented as
> 
>   We should never be called with any of these states
> 
> BUG() in a case that would later result in a NULL pointer dereference.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc1-mm3-full/fs/smbfs/request.c.old	2005-03-26 13:19:19.000000000 +0100
> +++ linux-2.6.12-rc1-mm3-full/fs/smbfs/request.c	2005-03-26 13:41:30.000000000 +0100
> @@ -786,8 +642,7 @@ int smb_request_recv(struct smb_sb_info 
>  		/* We should never be called with any of these states */
>  	case SMB_RECV_END:
>  	case SMB_RECV_REQUEST:
> -		server->rstate = SMB_RECV_END;
> -		break;
> +		BUG();
>  	}
>  
>  	if (result < 0) {

Can you please pick this one for next -mm?

Thanks,
-- 
Jean Delvare
