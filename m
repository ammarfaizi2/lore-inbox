Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVEEN2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVEEN2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 09:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVEEN2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 09:28:39 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:2732 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262103AbVEEN2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 09:28:36 -0400
Subject: Re: [2.6 patch] net/bluetooth/: possible cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: marcel@holtmann.or, maxk@qualcomm.com, bluez-devel@lists.sf.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050505002310.GF3593@stusta.de>
References: <20050505002310.GF3593@stusta.de>
Content-Type: text/plain
Date: Thu, 05 May 2005 15:28:30 +0200
Message-Id: <1115299710.8496.168.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This patch contains the following possible cleanups:
> - #ifdef HCI_DATA_DUMP the following function:
>   lib.c: bt_dump
> - #if 0 the following unused global functions:
>   - hci_core.c: hci_suspend_dev
>   - hci_core.c: hci_resume_dev
> - remove the following unneeded EXPORT_SYMBOL's:
>   - hci_core.c: hci_dev_get
>   - hci_core.c: hci_send_cmd
>   - hci_event.c: hci_si_event
> 
> Please review which of these changes do make sense and which conflict 
> with pending patches.

I like to let hci_suspend_dev() and hci_resume_dev() stay for now. No
driver uses it, but actually nobody really looked deep enough to really
understand the needs for suspend of Bluetooth devices.

The hci_dev_get(), hci_send_cmd() and hci_si_event() doesn't need to be
exported. And I think that the bt_dump() and and BT_DMP() stuff can be
removed completely.

Please redo the patch and actually it is enough to copy the bluez-devel
mailing list. I will take care of getting it back into mainline.

Regards

Marcel


