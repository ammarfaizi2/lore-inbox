Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVCCOT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVCCOT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVCCOT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:19:57 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:15793 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261754AbVCCOTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:19:55 -0500
Message-ID: <42271D12.90408@tiscali.de>
Date: Thu, 03 Mar 2005 15:20:02 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: pci_find_class obsolete
References: <Pine.LNX.4.61.0503031436490.22266@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0503031436490.22266@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>Hello list,
>
>
>after switching to 2.6.11-rc5-bk2 (from 2.6.9-rc2), I found that the nvidia 
>module (1.0-4996, old, I know) does not compile anymore, because it
>requires pci_find_class():
>
>nv.c:
>static int
>nvos_probe_devices(void)
>{
>    ...
>    struct pci_dev *dev;
>    ...
>    dev = pci_find_class(PCI_CLASS_DISPLAY_VGA << 8, dev);
>    ...
>}
>
>What function would I need to use, now that pci_find_class is gone?
>
>
>Jan Engelhardt
>  
>
Hi!
you have to use pci_get_class (). But have a look at the patches for 
6111 on my webiste:

http://unixforge.org/~matthias-christian-ott/index.php?entry=entry050303-082233

Matthias-Christian Ott
