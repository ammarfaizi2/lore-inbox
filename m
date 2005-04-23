Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVDWHjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVDWHjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 03:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVDWHjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 03:39:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59607 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261416AbVDWHjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 03:39:02 -0400
Subject: Re: [2.6 patch] fs/jffs2/: make some functions static
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: dwmw2@infradead.org, jffs-dev@axis.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050423000050.GK4355@stusta.de>
References: <20050423000050.GK4355@stusta.de>
Content-Type: text/plain
Date: Sat, 23 Apr 2005 09:38:50 +0200
Message-Id: <1114241931.6273.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-23 at 02:00 +0200, Adrian Bunk wrote:
> This patch makes some needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  fs/jffs2/compr_rubin.c |   18 ++++++++++++------


> --- linux-2.6.12-rc2-mm3-full/fs/jffs2/compr_rubin.c.old	2005-04-20 23:28:57.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/fs/jffs2/compr_rubin.c	2005-04-20 23:30:09.000000000 +0200
> @@ -228,8 +228,10 @@
>  	return rubin_do_compress(BIT_DIVIDER_MIPS, bits_mips, data_in, cpage_out, sourcelen, dstlen);
>  }
>  #endif
> -int jffs2_dynrubin_compress(unsigned char *data_in, unsigned char *cpage_out, 
> -		   uint32_t *sourcelen, uint32_t *dstlen, void *model)
> +static int jffs2_dynrubin_compress(unsigned char *data_in,
> +				   unsigned char *cpage_out, 
> +				   uint32_t *sourcelen, uint32_t *dstlen,
> +				   void *model)
>  {
>  	int bits[8];
>  	unsigned char histo[256];
> @@ -306,15 +308,19 @@
>  }		   
>  
> 
> -int jffs2_rubinmips_decompress(unsigned char *data_in, unsigned char *cpage_out, 
> -		   uint32_t sourcelen, uint32_t dstlen, void *model)
> +static int jffs2_rubinmips_decompress(unsigned char *data_in,
> +				      unsigned char *cpage_out, 
> +				      uint32_t sourcelen, uint32_t dstlen,
> +				      void *model)
>  {
>  	rubin_do_decompress(BIT_DIVIDER_MIPS, bits_mips, data_in, cpage_out, sourcelen, dstlen);
>          return 0;
>  }
>  
> -int jffs2_dynrubin_decompress(unsigned char *data_in, unsigned char *cpage_out, 
> -		   uint32_t sourcelen, uint32_t dstlen, void *model)
> +static int jffs2_dynrubin_decompress(unsigned char *data_in,
> +				     unsigned char *cpage_out, 
> +				     uint32_t sourcelen, uint32_t dstlen,
> +				     void *model)
>  {
>  	int bits[8];
>  	int c;


Acked-by: Arjan van de Ven <arjanv@infradead.org>


