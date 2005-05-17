Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVEQVRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVEQVRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVEQVRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:17:16 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:11486 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261946AbVEQVRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:17:11 -0400
Date: Tue, 17 May 2005 23:17:04 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops on CF removal and "convert device drivers to driver-model"
Message-ID: <20050517211704.GB7452@ojjektum.uhulinux.hu>
References: <20050514135019.0b3252f1.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050514135019.0b3252f1.zaitcev@redhat.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 01:50:19PM -0700, Pete Zaitcev wrote:
> @@ -1138,7 +1133,8 @@ static int idescsi_attach(ide_drive_t *d
>  	idescsi->host = host;
>  	idescsi->disk = g;
>  	g->private_data = &idescsi->driver;
> -	err = ide_register_subdriver(drive, &idescsi_driver);
> +	ide_register_subdriver(drive, &idescsi_driver);
> +	err = 0;
>  	if (!err) {
>  		idescsi_setup (drive, idescsi);
>  		g->fops = &idescsi_ops;


!err cannot be true here, so this seems buggy.




-- 
pozsy

