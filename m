Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269351AbUIIFxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269351AbUIIFxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 01:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUIIFxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 01:53:41 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:1474 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269351AbUIIFxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 01:53:39 -0400
Date: Thu, 09 Sep 2004 14:55:39 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] missing pci_disable_device()
In-reply-to: <1094647195.11723.5.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <413FF05B.8090505@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <413D0E4E.1000200@jp.fujitsu.com>
 <1094550581.9150.8.camel@localhost.localdomain>
 <413E7925.1010801@jp.fujitsu.com>
 <1094647195.11723.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-09-08 at 04:14, Kenji Kaneshige wrote:
>> > Think about unloading frame buffers or PCI devices with multiple
>> > functions and multiple drivers. I agree the drivers definitely want
>> > fixing where appropriate. I'm not sure your approach is safe (although a
>> 
>> I don't understand what you are worried about. Could you tell me
>> what would be a problem with frame buffers or PCI devices with
>> multiple functions?
> 
> If I have a framebuffer driver loaded for my video card in bitmap mode
> all is well. If I unload it you then disable the video hardware even
> though it would still be otherwise usable in text mode.
> 
> The same occurs when one PCI device has multiple functions (not PCI
> functions but linux drivers using it). There are some examples of this
> such as the CS5520 where one BAR is the IDE controller.
> 

Thank you for answering.

I understand that there are some devices that need to be enabled
even after their drivers are unloaded, and my approach might not
be safe in this case. I think the best way to solve the problem
(missing pci_disable_device) is to fix broken drivers one by one.
I think debug printk will helpful to fix those drivers, but I
don't know what kind of message is appropriate...

Thanks,
Kenji Kaneshige



