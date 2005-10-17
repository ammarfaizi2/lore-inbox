Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVJQLPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVJQLPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVJQLPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 07:15:22 -0400
Received: from main.gmane.org ([80.91.229.2]:40419 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932268AbVJQLPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 07:15:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 13:10:05 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.17.11.10.03.734742@smurf.noris.de>
References: <20051017044606.GA1266@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Cc: linux-ide@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff Garzik wrote:

>  config SCSI_SATA
> -	tristate "Serial ATA (SATA) support"
> +	bool "Serial ATA (SATA) support"
>	depends on SCSI

In other words, if SCSI is false then SCSI_SATA is false too.

So why are you doing

> +if SCSI_SATA
> +
>  config SCSI_SATA_AHCI
>  	tristate "AHCI SATA support"
> -	depends on SCSI_SATA && PCI
> +	depends on SCSI && PCI

and not just
  +     depends on PCI

?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
If you go out of your mind, do it quietly, so as not to disturb those
around you.


