Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUDMRco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUDMRco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:32:44 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:64946 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263642AbUDMRcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:32:35 -0400
Message-ID: <407C244D.70206@BitWagon.com>
Date: Tue, 13 Apr 2004 10:33:01 -0700
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf.c allow .bss with no access (p---)
References: <1078508281.3065.33.camel@linux.littlegreen>	<404A1C71.3010507@redhat.com>	<1078607410.10313.7.camel@linux.littlegreen>	<m1brn8us96.fsf@ebiederm.dsl.xmission.com>	<404C0B57.6030607@BitWagon.com>	<20040308080615.GS31589@devserv.devel.redhat.com>	<4050047F.5010808@BitWagon.com> <20040412185317.79ac7d7d.akpm@osdl.org>
In-Reply-To: <20040412185317.79ac7d7d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>>LOAD           0x001000 0x00400000 0x00400000 0x00000 0x10000000 R   0x1000
>>
>>>It should really be p_flags 0 and binfmt_elf.c should be fixed if it doesn't
>>>handle that properly.
>>
>>This ALPHA quality patch against 2.6.3 adds another argument to do_brk()
>>which enables having a user ELF .bss with no-access (or read-only).

Here are refreshed patches (now BETA quality) against recent kernels:
    http://www.bitwagon.com/elfdiet/elfdiet-2.6.5-mm5-1.patch.gz
    http://www.bitwagon.com/elfdiet/elfdiet-2.6.5.patch.gz
(Patch mechanics: take 2.6.5, apply -mm5-1 [if desired], then apply
the corresponding elfdiet patch.)

A short introduction with links to past and future patches is:
    http://www.bitwagon.com/elfdiet/elfdiet.html

-- 
John Reiser, jreiser@BitWagon.com

