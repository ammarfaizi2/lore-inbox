Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWGKOjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWGKOjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWGKOjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:39:45 -0400
Received: from gateway-1237.mvista.com ([63.81.120.155]:48441 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1750885AbWGKOjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:39:44 -0400
Message-ID: <44B3B7E8.3080800@ru.mvista.com>
Date: Tue, 11 Jul 2006 18:38:32 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ide/: cleanups
References: <20060711141637.GS13938@stusta.de>
In-Reply-To: <20060711141637.GS13938@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Adrian Bunk wrote:

> This patch contains the following clenups:
> - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
> - ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)

    It's used by arm/bast-ide.c (CONFIG_NLK_DEV_IDE_BAST is defined as 
tristate). I don't understand what's the point insisting on its removal since 
any SOC modular driver in the future may need it...

> - ide-dma.c: remove the unused EXPORT_SYMBOL_GPL(ide_in_drive_list)

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

WBR, Sergei
