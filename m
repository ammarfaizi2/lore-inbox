Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbUCKTU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUCKTU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:20:26 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:45193 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261653AbUCKTUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:20:24 -0500
Message-ID: <4050BBA1.2080804@BitWagon.com>
Date: Thu, 11 Mar 2004 11:18:57 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike@theoretic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf.c allow .bss with no access (p---)
References: <1078508281.3065.33.camel@linux.littlegreen> <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen> <m1brn8us96.fsf@ebiederm.dsl.xmission.com> <404C0B57.6030607@BitWagon.com> <20040308080615.GS31589@devserv.devel.redhat.com> <4050047F.5010808@BitWagon.com> <pan.2004.03.11.14.23.07.585954@codeweavers.com>
In-Reply-To: <pan.2004.03.11.14.23.07.585954@codeweavers.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This ALPHA quality patch against 2.6.3 adds another argument to do_brk()
>>which enables having a user ELF .bss with no-access (or read-only).

> Does this fix the Wine case where we have a new RO section that isn't the
> BSS?

Yes, because the patch considers each PT_LOAD with p_filesz < p_memsz
to have a "local" .bss.  This is more general than plain 2.6.3 which
creates only one "global" BSS after accumulating information from all
of the PT_LOAD.

-- 


