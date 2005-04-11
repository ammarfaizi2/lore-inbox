Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVDKDYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVDKDYK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVDKDYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:24:10 -0400
Received: from mail.aknet.ru ([217.67.122.194]:33549 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261676AbVDKDYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:24:06 -0400
Message-ID: <4259EDE0.8030509@aknet.ru>
Date: Mon, 11 Apr 2005 07:24:16 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: formatting CD-RW locks the system
References: <42597088.9050004@aknet.ru> <200504102136.09229.s0348365@sms.ed.ac.uk>
In-Reply-To: <200504102136.09229.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alistair John Strachan wrote:
> You probably don't have DMA enabled on the drive. Please check this.
It looks enabled. And even if it didn't,
such a behaviour would still be strange.

# hdparm -v /dev/cdrom

/dev/cdrom:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Invalid argument

> CDRW formatting works fine here with cdrecord blank=all
OK, I'll try cdrecord too, thanks.
But there might be a bug in the kernel
if the system literally dies with the
cdrwtool.

