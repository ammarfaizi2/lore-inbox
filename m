Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUGHSkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUGHSkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUGHSkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 14:40:17 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:27408 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264500AbUGHSkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 14:40:12 -0400
Message-ID: <40ED9A6F.8020506@techsource.com>
Date: Thu, 08 Jul 2004 15:03:11 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: kronos@kronoz.cjb.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Increasing IDE Channels
References: <20040707225635.GA26832@dreamland.darkstar.lan> <40ED6F1A.7080101@techsource.com> <20040708182654.GA10246@dreamland.darkstar.lan>
In-Reply-To: <20040708182654.GA10246@dreamland.darkstar.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kronos wrote:
> Il Thu, Jul 08, 2004 at 11:58:18AM -0400, Timothy Miller ha scritto: 
> 
>>>Because hwifs are statically allocated, see drivers/ide/ide.c:
>>>
>>>ide_hwif_t ide_hwifs[MAX_HWIFS];        /* master data repository */
>>>
>>>Also if names are ide0..ide9, the following would be ide: and ide; (see
>>>init_hwif_data in drivers/ide/ide.c).
>>>
>>
>>Why wouldn't they be ide10 and ide11?
> 
> 
> No:
> 
> static void init_hwif_data(ide_hwif_t *hwif, unsigned int index)
> {
>         ...
>         hwif->name[0]   = 'i';
>         hwif->name[1]   = 'd';
>         hwif->name[2]   = 'e';
>         hwif->name[3]   = '0' + index;
> 
> '0' + 10 is ':' and '0' + 11 is ';'
> 
> Luca


I understand WHY it's ':' and ';'.  I still think it's a bug.  Solaris 
rolls from 9 to 10, 11, etc.

