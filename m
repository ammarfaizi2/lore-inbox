Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUANSfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUANSfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:35:20 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:60367 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263130AbUANSfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:35:13 -0500
To: Tim Cambrant <tim@cambrant.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Newbie-warning] MOD_INC_USE_COUNT usage
References: <20040114172022.GA2112@cambrant.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 14 Jan 2004 19:25:04 +0100
In-Reply-To: <20040114172022.GA2112@cambrant.com> (Tim Cambrant's message of
 "Wed, 14 Jan 2004 18:20:22 +0100")
Message-ID: <m37jzuv14v.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Cambrant <tim@cambrant.com> writes:

> So, why shouldn't this patch be applied?:
>
> --- drivers/ide/pci/generic.c.orig      2004-01-14 17:52:35.000000000 +0100
> +++ drivers/ide/pci/generic.c   2003-11-24 13:54:01.000000000 +0100
> @@ -121,6 +121,7 @@ static int __devinit generic_init_one(st
> 		return 1;
> 	}
> 	ide_setup_pci_device(dev, d);
> +	MOD_INC_USE_COUNT;
> 	return 0;
>  }

It isn't that easy - the module must be marked as being in use this
way or (preferably) another.
-- 
Krzysztof Halasa, B*FH
