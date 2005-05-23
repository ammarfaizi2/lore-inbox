Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVEWN5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVEWN5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 09:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVEWN5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 09:57:51 -0400
Received: from zenon.apartia.fr ([82.66.93.83]:4575 "EHLO zenon.apartia.org")
	by vger.kernel.org with ESMTP id S261652AbVEWN5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 09:57:46 -0400
Message-ID: <4291E154.7020101@apartia.fr>
Date: Mon, 23 May 2005 15:57:40 +0200
From: Laurent CARON <lcaron@apartia.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
CC: Arjan van de Ven <arjan@infradead.org>
Subject: Re: New revision of promise TX4
References: <4291DDA5.3070706@apartia.fr> <1116856420.6280.28.camel@laptopd505.fenrus.org>
In-Reply-To: <1116856420.6280.28.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven a écrit :

>if it works.. almost
>the "right" way is to use "diff -purN" instead of just plain diff (it's
>custom) and to do the files the other way around (again custom). 
>  
>
diff -purN /usr/src/linux-2.6.11.9/drivers/scsi/sata_promise.c 
sata_promise.c
--- /usr/src/linux-2.6.11.9/drivers/scsi/sata_promise.c 2005-05-12 
00:42:30.000000000 +0200
+++ sata_promise.c      2005-05-23 15:56:09.000000000 +0200
@@ -167,6 +167,8 @@ static struct pci_device_id pdc_ata_pci_
          board_20319 },
        { PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_20319 },
+       { PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_20319 },

        { }     /* terminate list */
 };


>If you want to make it nice you add a PCI_ID_... constant for 0x3519 to
>the header and use the symbolic constant in your code instead.
>  
>
I did it like this mainly because the file was built like this (without 
pci ids in the header).

Regards,

Laurent
