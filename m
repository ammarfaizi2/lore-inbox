Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWFYX2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWFYX2j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 19:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFYX2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 19:28:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4488 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751149AbWFYX2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 19:28:38 -0400
Date: Sun, 25 Jun 2006 19:27:28 -0400
From: Alan Cox <alan@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, alan@redhat.com,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: Re: [-mm patch] make drivers/scsi/pata_it821x.c:it821x_passthru_dev_select() static
Message-ID: <20060625232728.GA20345@devserv.devel.redhat.com>
References: <20060624061914.202fbfb5.akpm@osdl.org> <20060625231324.GK23314@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625231324.GK23314@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 01:13:24AM +0200, Adrian Bunk wrote:
> On Sat, Jun 24, 2006 at 06:19:14AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-mm1:
> >...
> >  git-libata-all.patch
> >...
> >  git trees
> >...
> 
> This patch makes the needlessly global it821x_passthru_dev_select() 
> static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Alan Cox <alan@redhat.com>

> 
> --- linux-2.6.17-mm2-full/drivers/scsi/pata_it821x.c.old	2006-06-25 22:52:11.000000000 +0200
> +++ linux-2.6.17-mm2-full/drivers/scsi/pata_it821x.c	2006-06-25 22:52:52.000000000 +0200
> @@ -411,7 +411,8 @@
>   *	Device selection hook. If neccessary perform clock switching
>   */
>   
> -void it821x_passthru_dev_select(struct ata_port *ap, unsigned int device)
> +static void it821x_passthru_dev_select(struct ata_port *ap,
> +				       unsigned int device)
>  {
>  	struct it821x_dev *itdev = ap->private_data;
>  	if (itdev && device != itdev->last_device) {

-- 
	"Some people are like Slinkies...
	Not really good for anything,
	but they still bring a smile to your face
	when you push them down a flight of stairs."
			-- Gordon Wolfe.
