Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423096AbWJYIAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423096AbWJYIAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 04:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423102AbWJYIAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 04:00:53 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:4747 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423096AbWJYIAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 04:00:52 -0400
Date: Wed, 25 Oct 2006 10:00:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: arnd@arndb.de
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org,
       Christian Krafft <krafft@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 12/16] cell: add temperature to SPU and CPU sysfs entries
Message-ID: <20061025080048.GB7090@osiris.boeblingen.de.ibm.com>
References: <20061024163113.694643000@arndb.de> <20061024163816.851732000@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024163816.851732000@arndb.de>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 06:31:25PM +0200, arnd@arndb.de wrote:

> + * (C) Copyright IBM Deutschland Entwicklung GmbH 2005

IBM Corp. instead of IBM DE? 2006?

> +static int __init thermal_init(void)
> +{
> +	init_default_values();
> +
> +	spu_add_sysdev_attr_group(&spu_attribute_group);
> +	cpu_add_sysdev_attr_group(&ppe_attribute_group);
> +
> +	return 0;
> +}

Same here: check for errors on spu_add_sysdev_attr_group and
cpu_add_sysdev_attr_group.

> +static void __exit thermal_exit(void)
> +{
> +	spu_remove_sysdev_attr_group(&spu_attribute_group);
> +	cpu_remove_sysdev_attr_group(&ppe_attribute_group);

Will crash if cpu_add_sysdev_attr_group failed...
