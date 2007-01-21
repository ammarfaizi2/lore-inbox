Return-Path: <linux-kernel-owner+w=401wt.eu-S1751753AbXAUW44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbXAUW44 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 17:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbXAUW44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 17:56:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:42929 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbXAUW4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 17:56:55 -0500
In-Reply-To: <20070106131744.GC19020@Ahmed>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: linux-kernel@vger.kernel.org, sfrench@samba.org
Subject: Re: [PATCH 2.6.20-rc3] CIFS: Remove 2 unneeded kzalloc casts
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OF85D77A0B.7F3AA158-ON8725726A.007E0512-8625726A.007E146C@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Sun, 21 Jan 2007 16:56:53 -0600
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 7.0.2HF32 | October 17, 2006) at
 01/21/2007 15:56:53,
	Serialize complete at 01/21/2007 15:56:53
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thx - I have added these to the cifs git tree.


Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench at-sign us dot ibm dot com

"Ahmed S. Darwish" <darwish.07@gmail.com> wrote on 01/06/2007 07:17:44 AM:

> Hi, 
> A patch to remove two unnecessary kzalloc casts found
> 
> Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> 
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index aedf683..90f95ed 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -71,9 +71,7 @@ sesInfoAlloc(void)
>  {
>     struct cifsSesInfo *ret_buf;
> 
> -   ret_buf =
> -       (struct cifsSesInfo *) kzalloc(sizeof (struct cifsSesInfo),
> -                  GFP_KERNEL);
> +   ret_buf = kzalloc(sizeof (struct cifsSesInfo), GFP_KERNEL);
>     if (ret_buf) {
>        write_lock(&GlobalSMBSeslock);
>        atomic_inc(&sesInfoAllocCount);
> @@ -109,9 +107,8 @@ struct cifsTconInfo *
>  tconInfoAlloc(void)
>  {
>     struct cifsTconInfo *ret_buf;
> -   ret_buf =
> -       (struct cifsTconInfo *) kzalloc(sizeof (struct cifsTconInfo),
> -                   GFP_KERNEL);
> +   ret_buf = kzalloc(sizeof (struct cifsTconInfo),
> +           GFP_KERNEL);
>     if (ret_buf) {
>        write_lock(&GlobalSMBSeslock);
>        atomic_inc(&tconInfoAllocCount);
> 
> -- 
> Ahmed S. Darwish
> http://darwish-07.blogspot.com

