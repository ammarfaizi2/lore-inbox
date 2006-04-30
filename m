Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWD3Cw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWD3Cw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 22:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWD3Cw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 22:52:59 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:27104 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750888AbWD3Cw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 22:52:59 -0400
In-Reply-To: <20060429233922.167124000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain> <20060429233922.167124000@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org>
Cc: paulus@samba.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/13] cell: split out board specific files
Date: Sun, 30 Apr 2006 04:52:50 +0200
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Split the Cell BE support into generic and platform
> dependant parts.
>
> Creates a new config variable CONFIG_PPC_IBM_CELL_BLADE.
> The existing CONFIG_PPC_CELL is now used to denote the
> generic Cell processor support.  Also renames spu_priv1.c
> to spu_priv1_mmio.c.

>  config CELL_IIC
> -	depends on PPC_CELL
> +	depends on PPC_IBM_CELL_BLADE
>  	bool
>  	default y

Erm no...  Make this

	depends on PPC_CELL && !SOME_HYPERVISOR_THING

to reflect the _real_ dependency please?  Similar in a few other
places perhaps.


Segher

