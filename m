Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVAaLsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVAaLsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 06:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVAaLsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 06:48:55 -0500
Received: from borg.st.net.au ([65.23.158.22]:31681 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S261156AbVAaLsw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 06:48:52 -0500
Message-ID: <41FE1B39.6030702@torque.net>
Date: Mon, 31 Jan 2005 21:49:13 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Fabio Coatti <cova@ferrara.linux.it>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc[1,2]-mmX scsi cdrom problem, 2.6.10-mm2 ok
References: <200501310034.32005.cova@ferrara.linux.it> <20050131080021.GA9446@suse.de> <200501311108.19593.cova@ferrara.linux.it> <20050131110550.GA5058@suse.de>
In-Reply-To: <20050131110550.GA5058@suse.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Jan 31 2005, Fabio Coatti wrote:
> 
>>Alle 09:00, lunedì 31 gennaio 2005, Jens Axboe ha scritto:
>>
>>>>At this point k3b is stuck in D stat, needs reboot.
>>>
>>>The most likely suspect is the REQ_BLOCK_PC scsi changes. Can you try
>>>2.6.11-rc2-mm1 with bk-scsi backed out? (attached)
>>
>>just tried, right guess :)
>>backing out that patch the problem disappears.
>>Let me know if you need to narrow further that issue.
> 
> 
> Doug, it looks like your REQ_BLOCK_PC changes are buggy. Let me know if
> you cannot find the full post and I'll forward it to you.

Jens,
Hmm. Found the thread on lkml. I got an almost identical
lock up in k3b with a USB external cd/dvd drive recently.
My laptop didn't need rebooting (probably since the root
fs is one an ide disk).

That is a quite large patch that you referenced. I'll
try and replicate and report back.

Doug Gilbert

