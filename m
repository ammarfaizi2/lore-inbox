Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUAXVNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUAXVNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:13:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29924 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262015AbUAXVMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:12:51 -0500
Message-ID: <4012DFC7.4040709@pobox.com>
Date: Sat, 24 Jan 2004 16:12:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mgabriel@ecology.uni-kiel.de
CC: linux-kernel@vger.kernel.org
Subject: Re: vt6410 in kernel 2.6
References: <200401222238.09157.mgabriel@ecology.uni-kiel.de> <200401240047.19261.mgabriel@ecology.uni-kiel.de> <4011B4C8.50908@pobox.com> <200401240925.39986.mgabriel@ecology.uni-kiel.de>
In-Reply-To: <200401240925.39986.mgabriel@ecology.uni-kiel.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Gabriel wrote:
> hi jeff,
> 
> 
>>>>>is there any chance of upcoming support for the vt6410 ide/raid chipset
>>>>>in the 2.6.x kernel? there has been an attempt by via itself, but it
>>>>>only suits redhat 7.2 kernels and systems, thus it is highly specific.
>>>>>is there any1 who is working on that?
>>
>>CONFIG_BLK_DEV_GENERIC or CONFIG_SCSI_SATA_VIA should do it.
>>
> 
> 
> oh, i thought these options were for SATA only. what i need is the ide-part of 
> the controller. is this support by these options, as well? i will try as soon 
> as possible. i use a debian-backports kernel which for now always kills the 
> system during kernel-image-boot. as i use the board in one of our servers, i 
> cannot really fiddle around with it to much. thanks for your info.

My apologies.  The PATA part is handled by CONFIG_IDE, though 
drivers/ide/pci/via82cxxx.c may need another PCI id or two.  'lspci -n' 
will retrieve these ids.

	Jeff




