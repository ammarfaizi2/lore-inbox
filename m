Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbTGJLD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbTGJLD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:03:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56244
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266322AbTGJLD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:03:28 -0400
Subject: Re: [PATCH] 2.4.22-pre4 ide module fix init_cmd640_vlb
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Chua <jeff89@silk.corp.fedex.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0307101315480.845@boston.corp.fedex.com>
References: <Pine.LNX.4.56.0307101315480.845@boston.corp.fedex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057835714.8028.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 12:15:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-10 at 06:23, Jeff Chua wrote:
> Marcelo,
> 
> The following patch fixes problem when CONFIG_BLK_DEV_CMD640=y
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre4/kernel/drivers/ide/ide-core.o
> depmod:         init_cmd640_vlb
> 
> init_cmd640_vlb() doesn't exist. This patch removes the function call so
> that ide can be loaded as a module.

And stops it working for everyone else. The function does exist too. See
drivers/ide/pci/cmd640.c




