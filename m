Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269633AbUIRVQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269633AbUIRVQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 17:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269637AbUIRVQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 17:16:22 -0400
Received: from post.pl ([212.85.96.51]:2565 "HELO v00051.home.net.pl")
	by vger.kernel.org with SMTP id S269633AbUIRVPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 17:15:55 -0400
Message-ID: <414CA60F.60400@post.pl>
Date: Sat, 18 Sep 2004 23:18:07 +0200
From: Marcin Garski <mgarski@post.pl>
Reply-To: mgarski@post.pl
User-Agent: Mozilla Thunderbird 0.7.2 (Linux)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Copying huge amount of data on ReiserFS, XFS and Silicon Image
 3112 cause oops.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies, I am not subscribed to the list, thanks]

I've done some research and probably I've found thing that caused all 
this problems.
EXT-P2P's Discard Time in BIOS is default set to 30 us, when I've change 
this to 1 ms I couldn't reproduce any of my previous erros.

On Abit website in NF7-S V2.0 BIOS section there is interesting log in 
changelog:
"Fixed SATA RAID-0 data corruption issue by adding a new option
"EXT-P2P's Discard Time" in "integrated Peripherals". The default
setting is "30 us" ; which is recommended by NVidia. In case the problem 
is still there, try "1 ms" please."

I don't have RAID but somehow it (1 ms) fixed my problem.
Maybe if this is possible, kernel should change "Discard Time" to 1 ms 
on Abit NF7-S V2.0 ?

-- 
Best Regards
Marcin Garski
