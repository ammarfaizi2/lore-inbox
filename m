Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271177AbTGPWwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271195AbTGPWuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:50:40 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:24547 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S271188AbTGPWuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:50:17 -0400
Message-ID: <3F15DA25.5080406@cox.net>
Date: Wed, 16 Jul 2003 16:05:09 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
References: <1058395431.1481.6.camel@localhost.localdomain>
In-Reply-To: <1058395431.1481.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:

> GNU parted has had the GPT code for a couple years now, and
> CONFIG_EFI_PARTITION has been in both 2.4.x and 2.5.x trees for over a
> year.  To the best of my knowledge and experience, it works equally well
> on x86 as on IA-64, modulo booting with traditional BIOSs of course.
> 

When I rebuilt my server a few months back, I wanted to use GPT 
partitioning so I could have UUIDs on the partitions, etc. The 
stumbling block that I ran into is there are no boot loaders that 
support GPT partitioning (LILO and GRUB being the obvious ones). Even 
though my BIOS doesn't care and would load the MBR, that MBR has to 
accomplish something useful.

Since GPT partitioning is normally only used in IA-64 land, and all 
IA-64 systems come with EFI stuff that handles the tasks that 
LILO/GRUB would handle on an x86 system, I guess there hasn't been 
much demand for GPT support for non-EFI systems. So the BIOS is not 
really the issue, since "traditional BIOSs" (as Matt referred to them) 
  don't handle bootloading tasks at all except at the most basic level.

