Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWAFJaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWAFJaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbWAFJaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:30:24 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:16769 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750915AbWAFJaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:30:23 -0500
Message-ID: <43BE38AE.80203@namesys.com>
Date: Fri, 06 Jan 2006 01:30:22 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alexander Gran <alex@zodiac.dnsalias.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       Adam Belay <ambx1@neo.rr.com>, reiserfs-dev@namesys.com,
       Dave Airlie <airlied@linux.ie>, "Vladimir V. Saveliev" <vs@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: Re. 2.6.15-mm1
References: <200601051801.29007@zodiac.zodiac.dnsalias.org> <20060105144720.25085afa.akpm@osdl.org>
In-Reply-To: <20060105144720.25085afa.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>
>  
>
>>When X startet, the laptops crashed:
>>Jan  5 16:22:43 t40 kernel: <4>reiser4[syslogd(2729)]: disable_write_barrier 
>>(fs/reiser4/wander.c:233)[zam-1055]:
>>Jan  5 16:22:43 t40 kernel: WARNING: disabling write barrier
>>    
>>
>
>Vladimir, is that expected?
>  
>
Vladimir is in France skiing, as this is Russian Christmas right now. 

Zam says that this merely means that the underlying device does not
support write barriers, and the code uses synchronous writes for commits
instead of write barriers when this happens.  It should not affect
correctness.  He will comment more this evening (russian time) when he
gets home.   He suggests that he should change it from warning to
notice.  He also suggests that this code is new code, so it is possible
it has bugs.....

>  
>
>>Jan  5 16:22:43 t40 kernel:
>>Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing 
>>0xe0000000,0x4000000
>>Jan  5 16:22:48 t40 last message repeated 2 times
>>    
>>
>
>Is that new?
>
>  
>
>>Jan  5 16:22:48 t40 kernel: agpgart: Found an AGP 2.0 compliant device at 
>>0000:00:00.0.
>>Jan  5 16:22:48 t40 kernel: c028b7cf
>>Jan  5 16:22:48 t40 kernel: Modules linked in: irtty_sir sir_dev cfq_iosched 
>>ehci_hcd uhci_hcd
>>Jan  5 16:22:48 t40 kernel: EIP:    0060:[<c028b7cf>]    Not tainted VLI
>>Jan  5 16:22:48 t40 kernel: EFLAGS: 00013202   (2.6.15-mm1)
>>Jan  5 16:22:48 t40 kernel:        <0>c028b9e9 f762ff08 00000002 00000000 
>>c19720ec 00000000 1f000217 c1a79400
>>Jan  5 16:22:48 t40 kernel:        <0>00000032 00000001 c028bfb5 c0297262 
>>c1a79400 c02972af 1f000207 c029727f
>>    
>>
>
>hm, it's not clear what oopsed.   Can you get a cleaner copy of this?
>
>  
>
>>Jan  5 16:22:48 t40 kernel:  <3>[drm:drm_release] *ERROR* Device busy: 1 0
>>    
>>
>
>drm is unhappy
>
>
>
>  
>

