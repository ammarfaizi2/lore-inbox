Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVA0QBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVA0QBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVA0QBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:01:50 -0500
Received: from webapps.arcom.com ([194.200.159.168]:57612 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262654AbVA0QBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:01:43 -0500
Message-ID: <41F91065.6080304@arcom.com>
Date: Thu, 27 Jan 2005 16:01:41 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ara Avanesyan <araav@hylink.am>
CC: linux-kernel@vger.kernel.org
Subject: Re: ixdp4xx restart. watchdog enable value
References: <006b01c5047e$1efc78a0$1000000a@araavanesyan>
In-Reply-To: <006b01c5047e$1efc78a0$1000000a@araavanesyan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2005 16:05:50.0546 (UTC) FILETIME=[12179320:01C5048A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ara Avanesyan wrote:
> in file: include/asm-arm/arch-ixp4x//system.h
> function: arch_reset
> 
> code snap --
> /* disable watchdog interrupt, enable reset, enable count */
> *IXP4XX_OSWE = 0x3;
> --

See:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=2437

> I do not know why 0x3 works at all. Btw, u-boot assigns 0x5.

The count enable bit is irrelevant as the counter is initialized to
zero.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
