Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTENGqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTENGqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:46:07 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:52495 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S261188AbTENGqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:46:05 -0400
Message-Id: <200305140650.h4E6oCu04880@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: techstuff@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Posible memory leak!?
Date: Wed, 14 May 2003 09:56:56 +0300
X-Mailer: KMail [version 1.3.2]
References: <200305131415.37244.techstuff@gmx.net>
In-Reply-To: <200305131415.37244.techstuff@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 May 2003 21:15, you wrote:
>top - 11:03:41 up 4 min, š1 user, šload average: 0.12, 0.20, 0.09
>Tasks: š60 total, š 1 running, š58 sleeping, š 0 stopped, š 1 zombie
>Cpu(s): š 8.3% user, š 2.3% system, š 0.0% nice, š89.4% idle
>Mem: š š385904k total, š 173996k used, š 211908k free, š š14244k buffers
>Swap: š 128512k total, š š š š0k used, š 128512k free, š š86732k cached
>
>this is what the machine used to look like.
>
>this is what happens when the machine has run for about 3 hours, and during 
>that time I have had Netbeans and Day Of Defeat(wine) running for about 15 
>minutes.
>
>top - 14:14:49 up š2:31, š1 user, šload average: 0.03, 0.04, 0.01
>Tasks: š60 total, š 2 running, š57 sleeping, š 0 stopped, š 1 zombie
>Cpu(s): š 2.7% user, š 0.3% system, š 0.0% nice, š97.0% idle
>Mem: š š385904k total, š 261368k used, š 124536k free, š š16736k buffers
>Swap: š 128512k total, š š 8768k used, š 119744k free, š 175476k cached
>
>if i leave the machine on, and say I start transcoding something..
>the RAM would not be touched and the swap usage would shoot up to
>95%.

So far I see nothing abnormal. My current top:

09:51:53  up 16:40,  1 user,  load average: 0.02, 0.02, 0.00
56 processes: 55 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  0.2% user,  0.4% system,  0.0% nice,  0.0% iowait, 99.3% idle
Mem:   124616k av,  114444k used,   10172k free,       0k shrd,       4k buff
        53088k active,              46836k inactive
Swap:   76792k av,    1804k used,   74988k free                   53632k cached

Can you show "top b n1" (unabridged) and "cat /proc/meminfo", "cat /proc/slabinfo"
of the "swap usage shoot up to 95%" event?
--
vda
