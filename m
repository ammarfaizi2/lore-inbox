Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVCVVUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVCVVUE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVCVVUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:20:04 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:47860 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261965AbVCVVT5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:19:57 -0500
Date: Tue, 22 Mar 2005 21:19:52 +0000
From: Willem Riede <osst@riede.org>
Subject: Re: [2.6 patch] drivers/scsi/osst.c: make code static
To: James.Bottomley@SteelEye.com, Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, osst-users@lists.sourceforge.net,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050322142806.GR3982@stusta.de>
In-Reply-To: <20050322142806.GR3982@stusta.de> (from bunk@stusta.de on Tue
	Mar 22 09:28:07 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1111526392l.12349l.36l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2005 09:28:07 AM, Adrian Bunk wrote:
> This patch makes needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

James, I agree with this, can you put it in BK, please?

Signed-off-by: Willem Riede <osst@riede.org>
 
> ---
> 
> This patch was already sent on:
> - 28 Feb 2005
> 
>  drivers/scsi/osst.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.11-rc4-mm1-full/drivers/scsi/osst.c.old	2005-02-28 19:36:05.000000000 +0100
> +++ linux-2.6.11-rc4-mm1-full/drivers/scsi/osst.c	2005-02-28 19:36:25.000000000 +0100
> @@ -24,7 +24,7 @@
>  */
>  
>  static const char * cvsid = "$Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $";
> -const char * osst_version = "0.99.3";
> +static const char * osst_version = "0.99.3";
>  
>  /* The "failure to reconnect" firmware bug */
>  #define OSST_FW_NEED_POLL_MIN 10601 /*(107A)*/
> @@ -170,7 +170,7 @@
>  static int osst_probe(struct device *);
>  static int osst_remove(struct device *);
>  
> -struct scsi_driver osst_template = {
> +static struct scsi_driver osst_template = {
>  	.owner			= THIS_MODULE,
>  	.gendrv = {
>  		.name		=  "osst",
> 


