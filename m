Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUFTNI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUFTNI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 09:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUFTNI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 09:08:28 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:44747 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265354AbUFTNI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 09:08:27 -0400
Message-ID: <40D58C2F.3010508@colorfullife.com>
Date: Sun, 20 Jun 2004 15:07:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, "R. J. Wysocki" <rjwysocki@sisk.pl>
Subject: Re: Opteron bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:

>The kernel never uses backwards REP prefixes.
>  
>
Huh? memmove uses backwards rep movsb on x86-64, at least in 2.6.5:

http://lxr.linux.no/source/arch/x86_64/lib/memmove.c?v=2.6.5;a=x86_64#L8

i386 is similar:

http://lxr.linux.no/source/include/asm-i386/string.h?v=2.6.5#L297

But the bug appears to be so rare that it shouldn't matter - lets wait 
for the microcode update. Btw, is there a runtime microcode updater for 
Opteron cpus, similar to the Intel microcode driver?

--
    Manfred
