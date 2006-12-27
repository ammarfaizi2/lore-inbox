Return-Path: <linux-kernel-owner+w=401wt.eu-S932069AbWL0ToO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWL0ToO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 14:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWL0ToO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 14:44:14 -0500
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:2332 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbWL0ToN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 14:44:13 -0500
Subject: Re: idle RAID1 cpu usage
References: <20061227180900.GA10373@msgid.wurtel.net> <Pine.LNX.4.61.0612271915400.10556@yvahk01.tjqt.qr>
From: Paul Slootman <paul+nospam@wurtel.net>
Organization: Wurtelization
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Date: 27 Dec 2006 19:44:09 GMT
Message-ID: <4592cd09$0$339$e4fe514c@news.xs4all.nl>
X-Trace: 1167248649 news.xs4all.nl 339 [::ffff:83.68.3.130]:55611
X-Complaints-To: abuse@xs4all.nl
In-Reply-To: <Pine.LNX.4.61.0612271915400.10556@yvahk01.tjqt.qr>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt  <jengelh@linux01.gwdg.de> wrote:
>On Dec 27 2006 19:09, Paul Slootman wrote:
>>
>>This works fine, but I noticed that quite some time was being used by
>>the mdX_raid1 threads; even on a partition that's not even being used at
>>this time... (it was an empty mounted filesystem, but I umounted it to
>>be sure the filesystem code wasn't causing some IO).
>>
>>My question is: why is CPU being used by the RAID1 threads, even for
>>those devices that are otherwise unused? What are they doing?
>
>First-time synchronization (if applies), otherwise I suspect some
>housekeeping (bitmap perhaps?).

No, I had rebooted after the initial synchronization was complete.

>Otherwise it seems like a question who does what. On a raid5 array (i.e.
>cpu-heavy), both smbd and mdx_raid5 accumulate time for, of course, xor
>calculation.

On those devices that are actually in use, I'd understand CPU being
used; but where the device is not even mounted or used for swap or
whatever, I find that amount of CPU usage very high for just checking
the bitmap... I may take the idle device apart and reassemble without a
bitmap to see whether that makes any difference.


Paul Slootman
