Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbVA2Nje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbVA2Nje (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 08:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVA2Nh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 08:37:57 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:49116 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262910AbVA2Nhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 08:37:42 -0500
Message-ID: <41FB91A3.7060404@drzeus.cx>
Date: Sat, 29 Jan 2005 14:37:39 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx>
In-Reply-To: <41E22B4F.4090402@drzeus.cx>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Geert Uytterhoeven wrote:
> 
>> MMC_WBSD depends on ISA (needs isa_virt_to_bus())
>>
>>
> 
> Thanks. Shouldn't have missed something so obvious :)
> 
> Russell, can you fix this in your next merge?
> 

Russell, please undo this patch. isa_virt_to_bus() is not dependent on 
CONFIG_ISA. It causes problems on x86_64 platforms which cannot enable 
ISA support.

Rgds
Pierre
