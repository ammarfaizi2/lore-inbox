Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVACW3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVACW3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVACW0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:26:11 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:8249 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261923AbVACWZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:25:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=InR6OOi0y1n1MeEsKBFlHJ6BvTUHVlXNTEY4gBvmLq6wubJEKftD4zLUEFUFl9k6fqfHfmEBNui8Ob+3hDgNLX2WOlvARP3mUf2gn02QJvv6yzdEBD8c3i5L56agmzo/SDdUpCXB9MndRuRUQqo0Ay5PfPHB2qlrm6aK6hiPolA=
Message-ID: <58cb370e05010314254ccfc913@mail.gmail.com>
Date: Mon, 3 Jan 2005 23:25:06 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Peter Osterlund <petero2@telia.com>
Subject: Re: [PATCH] pktcdvd: make two functions static
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <m3acrqutwe.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050103011113.6f6c8f44.akpm@osdl.org> <m3acrqutwe.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While at it...

On 03 Jan 2005 21:42:09 +0100, Peter Osterlund <petero2@telia.com> wrote:
> Make two needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Peter Osterlund <petero2@telia.com>
> ---
> 
>  linux-petero/drivers/block/pktcdvd.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/block/pktcdvd.c~pktcdvd-static drivers/block/pktcdvd.c
> --- linux/drivers/block/pktcdvd.c~pktcdvd-static        2005-01-02 22:27:26.000000000 +0100
> +++ linux-petero/drivers/block/pktcdvd.c        2005-01-03 21:39:56.985007024 +0100
> @@ -2627,7 +2627,7 @@ static struct miscdevice pkt_misc = {
>         .fops           = &pkt_ctl_fops
>  };
> 
> -int pkt_init(void)
> +static int pkt_init(void)
>  {
>         int ret;
> 

__init

> @@ -2663,7 +2663,7 @@ out2:
>         return ret;
>  }
> 
> -void pkt_exit(void)
> +static void pkt_exit(void)
>  {
>         remove_proc_entry("pktcdvd", proc_root_driver);
>         misc_deregister(&pkt_misc);
> _

__exit
