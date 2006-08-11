Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWHKVoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWHKVoy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWHKVoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:44:54 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:11648 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750907AbWHKVox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:44:53 -0400
Date: Sat, 12 Aug 2006 07:40:21 +1000
From: Anton Blanchard <anton@samba.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 4/6] ehea: header files
Message-ID: <20060811214020.GG479@krispykreme>
References: <44D99F56.7010201@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D99F56.7010201@de.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>  drivers/net/ehea/ehea.h    |  452 

> +#define EHEA_DRIVER_NAME	"IBM eHEA"

You are using this for ethtool get_drvinfo. Im not sure if it should
match the module name, and I worry about having a space in the name. Any
ideas on what we should be doing here?

> +#define NET_IP_ALIGN 0

Shouldnt override this in your driver.

> +#define EDEB_P_GENERIC(level, idstring, format, args...) \
> +#define EDEB_P_GENERIC(level,idstring,format,args...) \
> +#define EDEB(level, format, args...) \
> +#define EDEB_ERR(level, format, args...) \
> +#define EDEB_EN(level, format, args...) \
> +#define EDEB_EX(level, format, args...) \
> +#define EDEB_DMP(level, adr, len, format, args...) \

There are a lot of debug statements in the driver. When doing a review
I stripped them all out to make it easier to read. As suggested by
others, using the standard debug macros (where still required) would be
a good idea.

Anton
