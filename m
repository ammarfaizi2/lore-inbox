Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWIOIAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWIOIAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWIOIAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:00:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25998 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751422AbWIOIAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:00:54 -0400
Subject: Re: [-mm patch 3/4] AVR32 MTD: Mapping driver for the
	ATSTK1000board
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060915095629.22cf01f4@cad-250-152.norway.atmel.com>
References: <20060914162926.6c117b36@cad-250-152.norway.atmel.com>
	 <20060914163026.49766346@cad-250-152.norway.atmel.com>
	 <20060914163121.241dec3e@cad-250-152.norway.atmel.com>
	 <20060914163259.068abe6d@cad-250-152.norway.atmel.com>
	 <1158264688.4312.82.camel@pmac.infradead.org>
	 <20060915095629.22cf01f4@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 09:00:30 +0100
Message-Id: <1158307230.24527.36.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 09:56 +0200, Haavard Skinnemoen wrote:
> Probably. I'll give it a try.
> 
> I have to find a way to unlock the flash at some point, though. Is it
> okay if I add code to physmap to iterate over the partitions and unlock
> the writable ones if info->mtd->unlock is non-null? Or is there a
> better way to do it?

I'm coming to the conclusion that if there are flash chips which inherit
the Intel insanity of automatically locking themselves on every power
cycle, thus rendering the 'locked' status meaningless, we should just
automatically unlock the whole chip at boot time, from the _chip_
driver.

That way, we can remove that hack from the board drivers which are
currently doing it.

> (btw, I got an "awaiting moderator approval" message from the linux-mtd
> mailer because "Message has a suspicious header". Can someone tell me
> more about this so I can fix my mailer?) 

Attachments would do that, but your patches were sensibly inlined.

In fact, your mail got trapped for moderation because you did the
_right_ thing -- you sent them in a thread, with References: headers to
keep them together. But because that means you have References: and no
'Re:' in the Subject: header, that's indistinguishable from the muppets
who try to start a new thread by replying to an existing mail and
changing the subject. So it's trapped for moderation and I get to look
at it and manually approve it.

-- 
dwmw2

