Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269013AbUIHDMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269013AbUIHDMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUIHDMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:12:45 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43946 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269013AbUIHDMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:12:43 -0400
Date: Wed, 08 Sep 2004 12:14:45 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] missing pci_disable_device()
In-reply-to: <1094550581.9150.8.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <413E7925.1010801@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <413D0E4E.1000200@jp.fujitsu.com>
 <1094550581.9150.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Maw, 2004-09-07 at 02:26, Kenji Kaneshige wrote:
>> Hi,
>> 
>> As mentioned in Documentaion/pci.txt, pci device driver should call
>> pci_disable_device() to deallocate any IRQ resources, disable PCI
>> bus-mastering and etc. when it decides to stop using the device.
>> But there seems to be many drivers that don't use pci_disable_device()
>> properly so far.
> 
> Think about unloading frame buffers or PCI devices with multiple
> functions and multiple drivers. I agree the drivers definitely want
> fixing where appropriate. I'm not sure your approach is safe (although a

I don't understand what you are worried about. Could you tell me
what would be a problem with frame buffers or PCI devices with
multiple functions?

> debug printk would work wonders perhaps ?)

Exactly. I think debug printk is more important because what we
really need is fixing all broken drivers which don't call
pci_disable_device().

Thanks,
Kenji Kaneshige


