Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317926AbSGKW3o>; Thu, 11 Jul 2002 18:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317927AbSGKW3n>; Thu, 11 Jul 2002 18:29:43 -0400
Received: from chfdns02.ch.intel.com ([143.182.246.25]:57073 "EHLO
	melete.ch.intel.com") by vger.kernel.org with ESMTP
	id <S317926AbSGKW3l>; Thu, 11 Jul 2002 18:29:41 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7F9A@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Dawson Engler'" <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Cc: mc@cs.Stanford.EDU
Subject: RE: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Date: Thu, 11 Jul 2002 15:32:24 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Dawson Engler [mailto:engler@csl.Stanford.EDU] 
> ---------------------------------------------------------
> [BUG]  all other case arms call __sti(); however, it may be 
> that safe_halt
>        does something weird.
> /u2/engler/mc/oses/linux/2.5.8/drivers/acpi/acpi_processor.c:5

#define safe_halt() __asm__ __volatile__("sti; hlt": : :"memory")

I think we're OK for now. I doubt safe_halt will change, but if it does I'll
fix this issue.

Regards -- Andy
