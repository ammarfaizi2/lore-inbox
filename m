Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTLJA7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTLJA7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:59:54 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:59582
	"EHLO bastard") by vger.kernel.org with ESMTP id S262762AbTLJA7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:59:52 -0500
Message-ID: <3FD67005.6060606@tupshin.com>
Date: Tue, 09 Dec 2003 16:59:49 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
References: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet> <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org> <20031210002737.GA27208@localhost>
In-Reply-To: <20031210002737.GA27208@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez wrote:

>On Tuesday, 09 December 2003, at 23:46:13 +0000,
>Paul Jakma wrote:
>
>  
>
>>There are people who store their data in LVM, we need compatibility,
>>and ideally we'd like to be able to migrate in small steps.
>>
>>    
>>
>Install "module-init-tools", install "LVM2" (that can drive both LVM1
>and DM Logical Volumes), compile a 2.6.x Linux kernel, reboot and you
>should be done.
>
>As far as I remember, migration is just that easy, and you can always go
>back to plain 2.4.x while you don't update LVM metadata to newer version 2.
>
>Greetings.
>
>  
>
This is not true. LVM2 can read the LVM1 format, but it cannot 
communicate with non-dm interfaces in 2.4.x. This means that you need to 
run lvm1 on 2.4 and lvm2 on 2.6 unless you patch 2.4 with dm.

If this were the whole story, then it would be an amazingly painful 
transition to (safely) upgrade an lvm machine from 2.4 to 2.6 (upgrade 
to patched 2.4, then upgrade to 2.6). Luckily, debian has made the lvm1 
and lvm2 packages not conflict, and the correct ones runs at startup 
depending on which kernel you have. This is probably a feature that all 
distros will have to adopt to ease the upgrade cycle.

-Tupshin
