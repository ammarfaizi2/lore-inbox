Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWDKUrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWDKUrB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWDKUrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:47:01 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:16775 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751362AbWDKUrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:47:01 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH] tpm: sysfs function buffer size fix
Date: Tue, 11 Apr 2006 22:45:01 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
References: <1144679825.4917.10.camel@localhost.localdomain> <20060411111834.587e4461.akpm@osdl.org> <1144786558.12054.14.camel@localhost.localdomain>
In-Reply-To: <1144786558.12054.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604112245.02443.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kylene,

On Tuesday, 11. April 2006 22:15, Kylene Jo Hall wrote:
> --- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm.c	2006-04-11 14:56:13.311776750 -0500
> +++ linux-2.6.17-rc1/drivers/char/tpm/tpm.c	2006-04-11 15:03:29.427032250 -0500
> @@ -490,7 +490,7 @@ static ssize_t transmit_cmd(struct tpm_c
>  
>  void tpm_gen_interrupt(struct tpm_chip *chip)
>  {
> -	u8 data[30];
> +	u8 data[max(ARRAY_SIZE(tpm_cap), 30)];
>  	ssize_t rc;
>  
>  	memcpy(data, tpm_cap, sizeof(tpm_cap));
> @@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(tpm_gen_interrupt);
>  
>  void tpm_get_timeouts(struct tpm_chip *chip)
>  {
> -	u8 data[30];
> +	u8 data[max(ARRAY_SIZE(TPM_CAP), 30)];
>  	ssize_t rc;
>  	u32 timeout;
>  

Once in ALL CAPS and once in lower case?
Sure about these?

Regards

Ingo Oeser
