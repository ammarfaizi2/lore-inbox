Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVCWMRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVCWMRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 07:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVCWMRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 07:17:07 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:44761 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261540AbVCWMQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 07:16:59 -0500
Date: Wed, 23 Mar 2005 12:16:54 +0000
From: Willem Riede <osst@riede.org>
Subject: Re: [2.6 patch] drivers/scsi/osst.c: remove unused code
To: Adrian Bunk <bunk@stusta.de>
Cc: osst-users@lists.sourceforge.net, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050322215948.GP1948@stusta.de>
In-Reply-To: <20050322215948.GP1948@stusta.de> (from bunk@stusta.de on Tue
	Mar 22 16:59:48 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1111580214l.12349l.37l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2005 04:59:48 PM, Adrian Bunk wrote:
> Thanks to both the Coverity checker and GNU gcc, it was found that this 
> variable is completely unused.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

And it is so obvious when your attention is drawn to it.
The code that did use it moved to os_scsi_tape_flush() recently.

James, could you make this change in BK too, please?

Signed-off-by: Willem Riede <osst@riede.org>

> --- linux-2.6.12-rc1-mm1-full/drivers/scsi/osst.c.old	2005-03-22 21:04:36.000000000 +0100
> +++ linux-2.6.12-rc1-mm1-full/drivers/scsi/osst.c	2005-03-22 22:09:32.000000000 +0100
> @@ -4770,9 +4770,6 @@ static int os_scsi_tape_close(struct ino
>  {
>  	int		      result = 0;
>  	struct osst_tape    * STp    = filp->private_data;
> -	struct scsi_request * SRpnt  = NULL;
> -
> -	if (SRpnt) scsi_release_request(SRpnt);
>  
>  	if (STp->door_locked == ST_LOCKED_AUTO)
>  		do_door_lock(STp, 0);
> 


