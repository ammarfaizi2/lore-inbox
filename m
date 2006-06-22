Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWFVKwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWFVKwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWFVKwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:52:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60322 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751527AbWFVKwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:52:38 -0400
Date: Thu, 22 Jun 2006 06:50:52 -0400
From: Alan Cox <alan@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, alan@redhat.com,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: Re: [-mm patch] make drivers/scsi/pata_pcmcia.c:pcmcia_remove_one() static
Message-ID: <20060622105052.GB14243@devserv.devel.redhat.com>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060621232012.GT9111@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621232012.GT9111@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 01:20:12AM +0200, Adrian Bunk wrote:
> On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-rc6-mm2:
> >...
> >  git-libata-all.patch
> >...
> >  git trees
> >...
> 
> This patch makes a needlessly global function static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Alan Cox <alan@redhat.com>

> 
> --- linux-2.6.17-mm1-full/drivers/scsi/pata_pcmcia.c.old	2006-06-22 00:43:23.000000000 +0200
> +++ linux-2.6.17-mm1-full/drivers/scsi/pata_pcmcia.c	2006-06-22 00:43:33.000000000 +0200
> @@ -294,7 +294,7 @@
>   *	cleanup. Also called on module unload for any active devices.
>   */
>  
> -void pcmcia_remove_one(struct pcmcia_device *pdev)
> +static void pcmcia_remove_one(struct pcmcia_device *pdev)
>  {
>  	struct ata_pcmcia_info *info = pdev->priv;
>  	struct device *dev = &pdev->dev;

-- 
--
	In Ximian did mad Miguel a mighty mail client decree
	Where Nat the crazy hacker ran
	Through sourcecode measureless to man
	And never coredump free

