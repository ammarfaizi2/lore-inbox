Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTLPMkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 07:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTLPMkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 07:40:24 -0500
Received: from hades.mk.cvut.cz ([147.32.96.3]:10937 "EHLO hades.mk.cvut.cz")
	by vger.kernel.org with ESMTP id S261539AbTLPMkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 07:40:23 -0500
Message-ID: <3FDEFD31.6050405@kmlinux.fjfi.cvut.cz>
Date: Tue, 16 Dec 2003 13:40:17 +0100
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re:Re: crypto-loop + highmen -> random crashes in -test11
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Soeren Sonnenburg <kernel@xxxxxx> wrote:
>>
>> Hi.
>>
>> I get random crashes/corruption/ init kills when I use cryptoloop on
>> this highmem enabled ppc machine.
> 
> People have reported cryptoloop+highmem crashes on ia32 as well. I'm not
> sure if that was with -mm though.

I tried to apply loop-highmem.patch, loop-highmem-fixes.patch, and 
loop-remove-blkdev-special-case.patch on a vanilla 2.6.0-test11, and it 
finally made the cryptoloop work on my machine - an Athlon XP, 1.5G RAM. 
Without the patch, cryptoloop+highmem didn't work at all - a fresh 
created ext2 was either impossible to mount, or it mounted corrupted, 
and cryptoloop overall seemed to act more like /dev/urandom.

Regards,
-- 
Jindrich Makovicka
