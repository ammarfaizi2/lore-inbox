Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVGHGzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVGHGzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGHGzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:55:31 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:52641
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S261386AbVGHGz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:55:29 -0400
Date: Fri, 8 Jul 2005 08:54:43 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Marcel Selhorst <selhorst@crypto.rub.de>
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com, adobriyan@gmail.com
Subject: Re: [PATCH] tpm: Support for new chip type
Message-ID: <20050708065443.GA28565@titan.lahn.de>
Mail-Followup-To: Marcel Selhorst <selhorst@crypto.rub.de>,
	linux-kernel@vger.kernel.org, kjhall@us.ibm.com, adobriyan@gmail.com
References: <42CDAFBA.5080005@crypto.rub.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CDAFBA.5080005@crypto.rub.de>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jul 08, 2005 at 12:42:02AM +0200, Marcel Selhorst wrote:
> +++ linux/drivers/char/tpm/tpm_infineon.c	2005-07-07 14:56:27.000000000 +0000
...
> + * Specifications at www.trustedcomputinggroup.org	
Blanks at end of line

> +/* Infineon specific delay definitions */
> +enum infineon_tpm_delay {
> +	TPM_MAX_WTX_PACKAGES = 50,	/* maximum number of WTX-packages */
> +	TPM_WTX_MSLEEP_TIME = 20,	/* msleep-Time for WTX-packages */
> +	TPM_MSLEEP_TIME = 3,	/* msleep-Time --> Interval to check status register */
> +	TPM_MAX_TRIES = 5000	/* gives number of max. msleep()-calls before
> +				   throwing timeout */
> +};
These look like unrelated constants, perhaps #define would be nicer?

> +static int wait(struct tpm_chip *chip, int wait_for_bit)
> +{
> +
blank line

> +}
> +static void tpm_inf_cancel(struct tpm_chip *chip)
missing blank line

> +static int __init tpm_inf_probe(struct pci_dev *pci_dev,
> +				const struct pci_device_id *pci_id)
> +{
> +
blank lines
> +		return 0;
> +
> +	} else {

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
