Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVLOViE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVLOViE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVLOViE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:38:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751126AbVLOViB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:38:01 -0500
Date: Thu, 15 Dec 2005 13:39:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       info-linux@ldcmail.amd.com, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/3] Geode LX HW RNG Support
Message-Id: <20051215133917.3f0a5171.akpm@osdl.org>
In-Reply-To: <20051215211423.GF11054@cosmic.amd.com>
References: <20051215211248.GE11054@cosmic.amd.com>
	<20051215211423.GF11054@cosmic.amd.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jordan Crouse" <jordan.crouse@amd.com> wrote:
>
> @@ -95,6 +100,11 @@ static unsigned int via_data_present (vo
>  static u32 via_data_read (void);
>  #endif
>  
> +static int __init geode_init(struct pci_dev *dev);
> +static void geode_cleanup(void);
> +static unsigned int geode_data_present (void);
> +static u32 geode_data_read (void);
> +
>  struct rng_operations {
>  	int (*init) (struct pci_dev *dev);
>  	void (*cleanup) (void);
> @@ -122,6 +132,7 @@ enum {
>  	rng_hw_intel,
>  	rng_hw_amd,
>  	rng_hw_via,
> +	rng_hw_geode,
>  };

Should all the Geode additions to hw_random.c be inside __i386__, like VIA?
