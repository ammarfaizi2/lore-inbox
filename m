Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSKMMkr>; Wed, 13 Nov 2002 07:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbSKMMkr>; Wed, 13 Nov 2002 07:40:47 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:43415 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261733AbSKMMkq>;
	Wed, 13 Nov 2002 07:40:46 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: akpm@digeo.com
Date: Wed, 13 Nov 2002 13:47:18 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] timers: fs/
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.50
Message-ID: <7649B06782F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 02 at 3:35, Linux Kernel Mailing List wrote:

> ChangeSet 1.843, 2002/11/12 19:35:24-08:00, akpm@digeo.com
> 
>     [PATCH] timers: fs/
>     
>     ncpfs has a dynamically allocated timer.
> 
> 
> # This patch includes the following deltas:
> #              ChangeSet    1.842   -> 1.843  
> #       fs/ncpfs/inode.c    1.33    -> 1.34   
> #
> 
>  inode.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> 
> diff -Nru a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
> --- a/fs/ncpfs/inode.c  Tue Nov 12 20:06:32 2002
> +++ b/fs/ncpfs/inode.c  Tue Nov 12 20:06:32 2002
> @@ -572,6 +572,7 @@
>     } else {
>         INIT_WORK(&server->rcv.tq, ncpdgram_rcv_proc, server);
>         INIT_WORK(&server->timeout_tq, ncpdgram_timeout_proc, server);
> +       init_timer(&server->timeout_tm);
>         server->timeout_tm.data = (unsigned long)server;
>         server->timeout_tm.function = ncpdgram_timeout_call;
>     }

Are you sure that timer is not already initialized, say at line 554
of fs/ncpfs/inode.c ?
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
