Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVKXKuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVKXKuv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVKXKuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:50:51 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:24488 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751358AbVKXKuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:50:50 -0500
Message-ID: <43859B03.5000302@bootc.net>
Date: Thu, 24 Nov 2005 10:50:43 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Koschewski <marc@osknowledge.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc2-mm1 problems
References: <3F1A9A2D-4726-42E9-A971-68F2B2782900@bootc.net> <20051124104538.GB6788@stiffy.osknowledge.org>
In-Reply-To: <20051124104538.GB6788@stiffy.osknowledge.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski wrote:
> * Chris Boot <bootc@bootc.net> [2005-11-23 23:45:49 +0000]:
> 
> 
>>On another note, I can't get the binary nVidia drivers to work, they  
>>complain about the following unresolved symbols:
>>
>>[4294682.396000] nvidia: module license 'NVIDIA' taints kernel.
>>[4294682.396000] nvidia: Unknown symbol pci_enable_device
>>[4294682.396000] nvidia: Unknown symbol pci_dev_put
>>[4294682.396000] nvidia: Unknown symbol pci_get_device
>>[4294682.396000] nvidia: Unknown symbol __pci_register_driver
>>[4294682.396000] nvidia: Unknown symbol pci_bus_write_config_byte
>>[4294682.396000] nvidia: Unknown symbol pci_unregister_driver
>>[4294682.396000] nvidia: Unknown symbol pci_bus_read_config_dword
>>[4294682.396000] nvidia: Unknown symbol pci_bus_read_config_word
>>[4294682.396000] nvidia: Unknown symbol pci_bus_write_config_dword
>>[4294682.397000] nvidia: Unknown symbol pci_set_master
>>[4294682.397000] nvidia: Unknown symbol pci_bus_write_config_word
>>[4294682.397000] nvidia: Unknown symbol pci_get_class
>>[4294682.397000] nvidia: Unknown symbol pci_disable_device
>>[4294682.397000] nvidia: Unknown symbol pci_bus_read_config_byte
>>
> 
> 
> http://www.nvnews.net/vbulletin/forumdisplay.php?s=&forumid=14

Hi there,

Thanks for that link, although I'm not sure exactly what you're pointing 
me at. I discovered last night (too late for me to post to LKML) that it 
was caused by a funny patch by Greg KH to mark most of the PCI symbols 
as EXPORT_SYMBOL_GPL. Once backed out it works fine. Go figure.

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
