Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUIWP7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUIWP7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUIWP7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:59:24 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:37268 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S266263AbUIWP7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:59:23 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mikhail Ramendik <mr@ramendik.ru>
Subject: Re: 2.6.8.1, USB , "IRQ 11 disabled" on plugging in a device
Date: Thu, 23 Sep 2004 09:59:19 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409230959.19570.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I plug in a USB device it is not recognized. It does not even
> appear in lsusb. And it says that it disables IRQ 11 - which is even 
> NOT the IRQ used by USB!

Does it make any difference if you boot with "pci=routeirq"?

There is a known problem with USB and prism54 devices not working
after suspend/resume, and it goes away with "pci=routeirq".

If that does make a difference, can you post the whole dmesg
log with and without it?
