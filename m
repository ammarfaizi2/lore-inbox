Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVHTFMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVHTFMc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 01:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVHTFMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 01:12:32 -0400
Received: from mail.dvmed.net ([216.237.124.58]:10464 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750863AbVHTFMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 01:12:31 -0400
Message-ID: <4306BBB9.4060201@pobox.com>
Date: Sat, 20 Aug 2005 01:12:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peer.Chen@uli.com.tw
CC: Alexey Dobriyan <adobriyan@gmail.com>, Alan Cox <alan@redhat.com>,
       Clear.Zhang@uli.com.tw, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Emily.Jiang@uli.com.tw
Subject: Re: [patch] net/tulip: LAN driver for ULI M5261/M5263
References: <OF308CFA6C.C728268D-ON4825705F.00365A7A@uli.com.tw>
In-Reply-To: <OF308CFA6C.C728268D-ON4825705F.00365A7A@uli.com.tw>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer.Chen@uli.com.tw wrote:
> Jeff:
> The attached file is the incremental patch to the original uli526x.c I send
> you first time,
> I modify the source according to your advice, thanks.
> 
> Signed-off-by: Peer Chen <Peer.Chen@uli.com.tw>
> (See attached file: patch_uli526x_inc)

Patch applied, thanks much.

I notice you removed the following code, rather than fixing it.  It is
OK to remove this code??


-       //add by clearzhang 2004/7/8
-       pci_read_config_dword(pdev,0x0,&configval);
-       m526x_id = configval;
-       if(configval == 0x526310b9)
-       {
-               //printk("is m5263\n");
-               pci_read_config_dword(pdev,0x0c,&configval);
-               configval = ((configval & 0xffff00ff) | 0x8000);
-               pci_write_config_dword(pdev,0x0c,configval);
-       }

Thanks,

	Jeff


