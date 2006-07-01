Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWGAHMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWGAHMD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 03:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWGAHMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 03:12:03 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:25360 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1751000AbWGAHMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 03:12:02 -0400
Message-ID: <44A62040.3050307@roarinelk.homelinux.net>
Date: Sat, 01 Jul 2006 09:12:00 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.17-mm4
References: <20060629013643.4b47e8bd.akpm@osdl.org>	<44A57970.7020501@roarinelk.homelinux.net> <20060630162625.2fe3b6cc.akpm@osdl.org>
In-Reply-To: <20060630162625.2fe3b6cc.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
>> With the attached .config, the kernel reliably panics when someone
>> issues a 'sync' (or the kernel decides to write back its buffers):
>>
>> reiser4 panicked cowardly: reiser4[sync(8465)]: commit_current_atom (fs/reiser4/txnmgr.c:1062)[zam-597]:
>> Kernel panic - not syncing: reiser4[sync(8465)]: commit_current_atom (fs/reiser4/txnmgr.c:1062)[zam-597]:
>>
>> (this is all that is printed)
>>
>> This happens only with Reiser4 and libata ata_piix driver; it does not
>> happen with Reiser4 and 'old' IDE piix driver. Other fs are also not
>> affected. I have no idea how to track this, I hope someone else does :)
>>
>> Hardware is a pentium-m laptop with ICH4 pata.
>>

> My guess would be that there's a difference in the way in which the two
> drivers handle write barriers, and the new driver has confused the reiser4
> code.
> 
> Are you able to identify any earlier -mm kernel which ran OK with reiser4
> and ata_piix?

-mm1 and -mm2 are good, mm3 and mm4 are broken.

-- 
 Manuel Lauss
