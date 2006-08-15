Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965277AbWHOHkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbWHOHkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 03:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965262AbWHOHkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 03:40:10 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:11700 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S965221AbWHOHkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 03:40:08 -0400
Date: Tue, 15 Aug 2006 09:39:59 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 1/7] ehea: interface to network stack
Message-ID: <20060815073959.GB6922@osiris.boeblingen.de.ibm.com>
References: <44E0A4CC.4090705@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E0A4CC.4090705@de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +int __init ehea_module_init(void)
> +{
> +	int ret = -EINVAL;
> +
> +	EDEB_EN(7, "");
> +
> +	printk(KERN_INFO "IBM eHEA Ethernet Device Driver (Release %s)\n",
> +	       DRV_VERSION);
> +
> +
> +	ret = ibmebus_register_driver(&ehea_driver);
> +	if (ret) {
> +		EDEB_ERR(4, "Failed registering eHEA device driver on ebus");
> +		return -EINVAL;
> +	}
> +
> +	EDEB_EX(7, "");
> +	return 0;
> +}

Function should be static and could be shortened to the single line

return ibmebus_register_driver(&ehea_driver);

, I guess :)
