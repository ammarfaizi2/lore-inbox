Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbULaCUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbULaCUe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 21:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbULaCUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 21:20:34 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:37747 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261810AbULaCUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 21:20:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CN59wKFrJafmZ8EVyZfOeB+U8PFmELOl2ADJU/nx//4L63oG8vicZZ5Ktu1BzDIvz/N5+rFEpZLgdPtOYtsuosAJlIcQuRP18q/dRx35fpz0BG50FmqFPW9K12f5CfzaIc9+SXkc44ZIGth1spDbLkASyOipy7EkxCyjyifwON4=
Message-ID: <2cd57c9004123018203b7e38ef@mail.gmail.com>
Date: Fri, 31 Dec 2004 10:20:25 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: printk loglevel policy?
Cc: David Howells <dhowells@redhat.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412310259230.4725@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.61.0412310259230.4725@dragon.hygekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 

Recently, I've seen a lot of add loglevel to printk patches. 
grep 'printk("' -r | wc shows me 2433. There are probably 2433 printk
need to patch, is it?  What's this printk loglevel policy, all these
printk calls need loglevel adjusted?  The default loglevel is
KERN_WARNING.


--coywolf



On Fri, 31 Dec 2004 03:02:57 +0100 (CET), Jesper Juhl <juhl-lkml@dif.dk> wrote:
> 
> Hi,
> 
> below is a small patch that adds loglevel to a printk in
> fs/afs/cmservice.c
> 
> If considered OK please consider applying.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.10-bk2-orig/fs/afs/cmservice.c linux-2.6.10-bk2/fs/afs/cmservice.c
> --- linux-2.6.10-bk2-orig/fs/afs/cmservice.c    2004-12-24 22:34:44.000000000 +0100
> +++ linux-2.6.10-bk2/fs/afs/cmservice.c 2004-12-31 02:59:13.000000000 +0100
> @@ -118,7 +118,7 @@ static int kafscmd(void *arg)
>         _SRXAFSCM_xxxx_t func;
>         int die;
> 
> -       printk("kAFS: Started kafscmd %d\n", current->pid);
> +       printk(KERN_INFO "kAFS: Started kafscmd %d\n", current->pid);
> 
>         daemonize("kafscmd");
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
