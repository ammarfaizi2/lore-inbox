Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWAQRBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWAQRBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWAQRBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:01:14 -0500
Received: from [221.158.187.116] ([221.158.187.116]:64977 "EHLO comet.localnet")
	by vger.kernel.org with ESMTP id S932196AbWAQRBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:01:13 -0500
Message-Id: <200601171700.k0HH0rAf000466@comet.localnet>
Cc: lkml <linux-kernel@vger.kernel.org>, Kylene Hall <kjhall@us.ibm.com>,
       <tpmdd-devel@lists.sourceforge.net>
Subject: Re: [PATCH][2.6.16-rc1] TPM: tpm_bios needs securityfs (CONFIG_SECURITY)
User-Agent: Mail::Sendmail v0.79
In-Reply-To: <Pine.LNX.4.64.0601171359120.25253@joel.ist.utl.pt>
Content-Disposition: inline
Date: Wed, 18 Jan 2006 02:00:53 +0900
References: <Pine.LNX.4.64.0601171359120.25253@joel.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Rui Saraiva <rmps@joel.ist.utl.pt>
Content-Transfer-Encoding: 8bit
From: Jerome Pinot <ngc891@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
 >It seems that "TPM Hardware Support" (CONFIG_TCG_TPM) depends on
 >"Enable different security models" (CONFIG_SECURITY).
 
 This does the trick but your patch formatting is broken. This one
 applies cleanly against 2.6.16-rc1.
 
 from: Rui Saraiva
 
 tpm_bios (CONFIG_TCG_TPM) depends on securityfs (CONFIG_SECURITY).
 
 Signed-off-by: Rui Saraiva <rmps@mail.pt>
 Signed-off-by: Jerome Pinot <ngc891@gmail.com>
 
 ---
 diff -Naur a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
 --- a/drivers/char/tpm/Kconfig	2006-01-17 16:12:37.000000000 +0000
 +++ b/drivers/char/tpm/Kconfig	2006-01-17 16:13:05.000000000 +0000
 @@ -6,7 +6,7 @@
  
  config TCG_TPM
  	tristate "TPM Hardware Support"
 -	depends on EXPERIMENTAL
 +	depends on EXPERIMENTAL && SECURITY
  	---help---
  	  If you have a TPM security chip in your system, which
  	  implements the Trusted Computing Group's specification,

