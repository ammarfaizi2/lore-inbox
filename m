Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVHAQTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVHAQTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVHAQPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:15:09 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:32818 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262111AbVHAQOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:14:42 -0400
Message-ID: <42EE4ADF.4080502@gentoo.org>
Date: Mon, 01 Aug 2005 17:16:31 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Otto Meier <gf435@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net>
In-Reply-To: <42EE3FB8.10008@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Meier wrote:
> My question is also are these features (NCQ/TCQ) and the heigher 
> datarate be supported by this
> modification? or is only the basic feature set of sata 150 TX4 supported?

NCQ support is under development. Search the archives for Jens Axboe's recent 
patches to support this. I don't know about TCQ.

> Here is the patch:
> 
> --- linux/drivers/scsi/sata_promise.c.orig 2005-08-01 17:09:48.474824778 
> +0200
> +++ linux/drivers/scsi/sata_promise.c 2005-07-31 12:57:06.415979512 +0200

Your patch will not apply because it is linewrapped. You also need to submit 
it in a mail of its own to the relevent lists and maintainer, with your 
sign-off  (see Documentation/SubmittingPatches)

> I just saw the patches of  Luke Kosewski regarding the SATA150 TX4 
> antipating
> them it might be right to modify the patch to
> 
> + { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> + board_40518 },

It won't compile like this because board_40518 is not a valid identifier. I 
also think it doesn't really matter as it looks like these identifier codes 
have lost their numerical meanings, and now just signify:

board_2037x - 2 port SATA, maybe with an extra PATA port
board_20319 - 4 port SATA
board_20619 - 4 port PATA

Daniel
