Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbUBPCOo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUBPCOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:14:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265326AbUBPCOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:14:42 -0500
Message-ID: <40302783.6020505@pobox.com>
Date: Sun, 15 Feb 2004 21:14:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chip Salzenberg <chip@pobox.com>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com> <200402151808.42611.bzolnier@elka.pw.edu.pl> <20040216005523.GD3789@perlsupport.com>
In-Reply-To: <20040216005523.GD3789@perlsupport.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg wrote:
> According to Bartlomiej Zolnierkiewicz:
> 
>>On Sunday 15 of February 2004 17:34, Chip Salzenberg wrote:
>>
>>>http://bugzilla.kernel.org/show_bug.cgi?id=2110
>>>
>>>I've also included the SMART error dumps ("smartctl -a").  There are
>>>no media problems, if I'm reading it right; whatever else is broken,
>>>the IDE DMA errors seem to be unrelated to actual bad sectors.
>>
>>There is a media error at sector 4682265. :-(
> 
> 
> Damn.  Is there a HOWTO on forcing the remapping of a known bad sector?

Ideally the drive should do it automatically, and if it can't remap, 
it's run out of spare sectors to remap bad ones to (uh oh).

Really the best policy IMO is just to run 'e2fsck -c' every so often 
until you can get your data off this disk, and throw it in the garbage. 
  That does the "remapping" at the filesystem level, which is IMO easier 
than bothering with low-level ATA commands.

I'm a bit fuzzy on SMART and Device Configuration Overlay and need to 
review.  Those are sets of ATA commands, and they -might- allow you to 
remap at a low-level.  I know vendor-specific commands exist to do 
precisely what you want, but those are unfortunately NDA'd and I don't 
know them, just that they exist...

	Jeff



