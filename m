Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265583AbUABPig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 10:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUABPig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 10:38:36 -0500
Received: from firewall.conet.cz ([213.175.54.250]:2972 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265583AbUABPib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 10:38:31 -0500
Message-ID: <3FF59073.3060305@conet.cz>
Date: Fri, 02 Jan 2004 16:38:27 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il>
In-Reply-To: <20040102151206.GJ1718@actcom.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>I'm writing some project which needs to hijack some syscalls in VFS 
>>layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
>>some very nasty ways of doing it - see 
>>http://mail.nl.linux.org/kernelnewbies/2002-12/msg00266.html )
>>    
>>
>
>Why do you need to hijack system calls from a module? 99% of the
>times, it's the wrong technical solution. 
>  
>
I'm working on my diploma thesis which is adding snapshot capability 
into Linux VFS (so you can do directory based snapshots - not complete 
device, like in LVM). It'll consist of two separete modules:
Snapshot module:
- will hijack (one or another way) calls to open/move/unlink/mkdir/etc. 
syscall
- when will detect change to selected directory (which I want to 
snapshot), it'll copy/move old file/directory to some temporary 
(selected when creating snapshot) - in fact - copy on write behaviour

UnionFS module:
- will place "temporary" directory with saved files/dirs "over" actual 
one and result will be read-only snapshot - this can be done without 
hijacking syscalls probably
- something like overlay fs but a bit different

-- 

Libor Vanek



