Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbUBXSQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUBXSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:16:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61378 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262375AbUBXSQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:16:13 -0500
Message-ID: <403B94D2.8040507@pobox.com>
Date: Tue, 24 Feb 2004 13:15:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Henrik Gustafsson <henrik.gustafsson@fnord.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise SATA driver
References: <200402241110.07526.andrew@walrond.org> <20040224154446.GA28720@ee.oulu.fi> <403B73E3.80100@pobox.com> <200402241630.36105.andrew@walrond.org> <403B8028.1060700@pobox.com> <opr3vv7qk4uwbm4s@localhost> <403B8587.3030009@pobox.com> <opr3vxlywuuwbm4s@localhost>
In-Reply-To: <opr3vxlywuuwbm4s@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Gustafsson wrote:
> I happen to have such a card in a computer here. Right now it's not used
> for anything in particular (waiting for things to stabilising a bit) so
> I can test out patches without worrying about any data on it, so feel
> free to suggest things to try.
> 
> Is there any active development done on it?

Well, the basic SX4 SATA driver is pretty much done.  There is one 
bugfix I need to merge for PCI-X, but that's it.

Unfortunately, it is a bit slower than average since every request must 
bounce through RAM first, with no queueing.

Using the on-board DIMM as a write-through cache would boost performance 
significantly.


> My current working conditions (and lack of specs for the card) prevents me
> from doing much work on it myself atm, but is there perhaps another way of
> following the development on that part a bit more closely?
> 
> I have done my (small, but still... :) ) share of driver development and
> low-level coding (company I work for makes me write code for their embedded
> devices and sometimes drivers for the PC-interfaces) so I might just be
> able to pitch in with an idea or two.

Well, the specs are under NDA but are available from Promise.

However...  if you want to tackle creating the write-through cache, that 
shouldn't require any specs at all.  If you are knowledgeable enough to 
create generic write-through cache code for an ATA drive, that's 
sufficient :)

	Jeff



