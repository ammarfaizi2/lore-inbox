Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWAQRZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWAQRZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWAQRZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:25:46 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:55938 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932214AbWAQRZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:25:45 -0500
Subject: Re: [PATCH][2.6.16-rc1] TPM: tpm_bios needs securityfs
	(CONFIG_SECURITY)
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Jerome Pinot <ngc891@gmail.com>
Cc: Rui Saraiva <rmps@joel.ist.utl.pt>, lkml <linux-kernel@vger.kernel.org>,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <200601171700.k0HH0rAf000466@comet.localnet>
References: <Pine.LNX.4.64.0601171359120.25253@joel.ist.utl.pt>
	 <200601171700.k0HH0rAf000466@comet.localnet>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 11:26:48 -0600
Message-Id: <1137518808.4873.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack'ed-by: Kylene Hall <kjhall@us.ibm.com>

On Wed, 2006-01-18 at 02:00 +0900, Jerome Pinot wrote:
> Hi,
>  
>  >It seems that "TPM Hardware Support" (CONFIG_TCG_TPM) depends on
>  >"Enable different security models" (CONFIG_SECURITY).
>  
>  This does the trick but your patch formatting is broken. This one
>  applies cleanly against 2.6.16-rc1.
>  
>  from: Rui Saraiva
>  
>  tpm_bios (CONFIG_TCG_TPM) depends on securityfs (CONFIG_SECURITY).
>  
>  Signed-off-by: Rui Saraiva <rmps@mail.pt>
>  Signed-off-by: Jerome Pinot <ngc891@gmail.com>
>  
>  ---
>  diff -Naur a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>  --- a/drivers/char/tpm/Kconfig	2006-01-17 16:12:37.000000000 +0000
>  +++ b/drivers/char/tpm/Kconfig	2006-01-17 16:13:05.000000000 +0000
>  @@ -6,7 +6,7 @@
>   
>   config TCG_TPM
>   	tristate "TPM Hardware Support"
>  -	depends on EXPERIMENTAL
>  +	depends on EXPERIMENTAL && SECURITY
>   	---help---
>   	  If you have a TPM security chip in your system, which
>   	  implements the Trusted Computing Group's specification,
> 
> 

