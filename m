Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSIIQQe>; Mon, 9 Sep 2002 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSIIQQe>; Mon, 9 Sep 2002 12:16:34 -0400
Received: from [63.209.4.196] ([63.209.4.196]:49158 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317482AbSIIQQd>; Mon, 9 Sep 2002 12:16:33 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH][RFC] per isr in_progress markers
Date: Mon, 9 Sep 2002 16:24:46 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <alii0e$baf$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0209081700460.1096-100000@linux-box.realnet.co.sz> <Pine.LNX.4.44.0209081453010.1293-100000@home.transmeta.com> <20020909064916.GA30669@outpost.ds9a.nl>
X-Trace: palladium.transmeta.com 1031588476 24674 127.0.0.1 (9 Sep 2002 16:21:16 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 9 Sep 2002 16:21:16 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020909064916.GA30669@outpost.ds9a.nl>,
bert hubert  <ahu@ds9a.nl> wrote:
>On Sun, Sep 08, 2002 at 03:01:02PM -0700, Linus Torvalds wrote:
>
>>    setups (as opposed to most laptops, which often seem to put every PCI
>>    device on the same irq)
>
>I've always thought that this was a linux problem - any reason *why* laptops
>do this?

I have no idea why, but according to the irq routing information, the
irq lines really often _are_ wired to the same pin on the irq
controller. 

(Oh, I'm sure there are cases where Linux ends up using the same irq
even when it isn't necessary, but equally often everything really is on
just irq 9 or something like that). 

There may be good reasons for it, but I suspect it's one of those "we
are lazy, and it was just easier to tie those lines together" things at
design time. It might make for one less pin used, and potentially makes
the PIRQ table easier to write. Whatever.

		Linus
