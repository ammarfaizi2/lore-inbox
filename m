Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbTBJBiU>; Sun, 9 Feb 2003 20:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267507AbTBJBhJ>; Sun, 9 Feb 2003 20:37:09 -0500
Received: from dp.samba.org ([66.70.73.150]:56237 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267515AbTBJBg5>;
	Sun, 9 Feb 2003 20:36:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, AKellner@connectcom.net,
       support@connectcom.net
Subject: Re: [PATCH] 2.5.59 : drivers/scsi/advansys.c 
In-reply-to: Your message of "Fri, 07 Feb 2003 12:24:54 CDT."
             <Pine.LNX.4.44.0302071223250.6917-100000@master> 
Date: Mon, 10 Feb 2003 11:35:47 +1100
Message-Id: <20030210014642.57BD62C2B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302071223250.6917-100000@master> you write:
> Hello all,
>    The following patch addresses buzilla bug # 324, and removes a double 
> logical issue. Please review for inclusion.
> 
> Regards,
> Frank

Once again, the author needs to say what they want here.

Andy?

Thanks,
Rusty.


> --- linux/drivers/scsi/advansys.c.old	2003-01-16 21:21:49.000000000 -0500
> +++ linux/drivers/scsi/advansys.c	2003-02-07 02:09:58.000000000 -0500
> @@ -7100,7 +7100,7 @@
>           * then return the number of underrun bytes.
>           */
>          if (scp->request_bufflen != 0 && qdonep->remain_bytes != 0 &&
> -            qdonep->remain_bytes <= scp->request_bufflen != 0) {
> +            qdonep->remain_bytes <= scp->request_bufflen && scp->request_bufflen!= 0) {
>              ASC_DBG1(1, "asc_isr_callback: underrun condition %u bytes\n",
>              (unsigned) qdonep->remain_bytes);
>              scp->resid = qdonep->remain_bytes;
> 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
