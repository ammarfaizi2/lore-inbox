Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261794AbTCLRtc>; Wed, 12 Mar 2003 12:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261821AbTCLRtc>; Wed, 12 Mar 2003 12:49:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29197 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261794AbTCLRta>; Wed, 12 Mar 2003 12:49:30 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: bio too big device
Date: Wed, 12 Mar 2003 17:59:03 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b4nsh7$eg0$1@penguin.transmeta.com>
References: <20030312090943.GA3298@suse.de> <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org> <20030312101414.GB3950@suse.de> <20030312154440.GA4868@win.tue.nl>
X-Trace: palladium.transmeta.com 1047491986 27573 127.0.0.1 (12 Mar 2003 17:59:46 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Mar 2003 17:59:46 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030312154440.GA4868@win.tue.nl>,
Andries Brouwer  <aebr@win.tue.nl> wrote:
>On Wed, Mar 12, 2003 at 11:14:14AM +0100, Jens Axboe wrote:
>
>> So I still think it's much better stick with the safe choice. Why do you
>> think it's only one drive that has this bug? It basically boils down to
>> whether That Other OS uses 256 sector commands or not. If it doesn't, I
>> wouldn't trust the drives one bit.
>
>I am not quite sure I understand your reasoning.
>We have seen *zero* drives that do not understand 256 sector commands.
>Maybe such drives exist, but so far there is zero evidence.

That is definitely not true.  We definitely _have_ had drives that
misconstrue the 256-sector case. It's been a long time, but they
definitely exist.

The right limit for IDE is 255 sectors, and doing 256 sectors WILL fail
on some setups.

		Linus
