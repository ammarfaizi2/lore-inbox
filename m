Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVJCSjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVJCSjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVJCSjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:39:09 -0400
Received: from [81.2.110.250] ([81.2.110.250]:48592 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750823AbVJCSjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:39:08 -0400
Subject: Re: [PATCH 5/7] AMD Geode GX/LX support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com,
       linux-ide@vger.kernel.org
In-Reply-To: <20051003175851.GG29264@cosmic.amd.com>
References: <20051003175851.GG29264@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 20:06:32 +0100
Message-Id: <1128366392.26992.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-03 at 11:58 -0600, Jordan Crouse wrote:

> +
> +	hwif->udma_four = w80;  /* w80 = 1 if a 80 conductor line is attached */
> +
> +	if (hwif->mate)
> +		hwif->serialized = hwif->mate->serialized = 1;

Is this needed, it doesn't seem to be in the databook or errata ?


> Index: linux-2.6.14-rc2-mm2/drivers/ide/pci/cs5535.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6.14-rc2-mm2/drivers/ide/pci/cs5535.h
> @@ -0,0 +1,72 @@

Please put the private structure into the .c file as the other code now
does. Its a tidy up that wants picking up.


