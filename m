Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWAILbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWAILbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 06:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWAILbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 06:31:35 -0500
Received: from gprs-pool-1-001.eplus-online.de ([212.23.126.1]:17107 "EHLO
	strolchi.suse.de") by vger.kernel.org with ESMTP id S1751235AbWAILbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 06:31:34 -0500
Date: Mon, 9 Jan 2006 12:30:50 +0100
From: Stefan Seyfried <seife@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [2.6 patch] remove drivers/net/tulip/xircom_tulip_cb.c
Message-ID: <20060109113050.GA11196@strolchi>
References: <20060106192123.GB12131@stusta.de> <1136575714.2940.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1136575714.2940.73.camel@laptopd505.fenrus.org>
X-Operating-System: SUSE LINUX 10.0.42 (i586) Beta1, Kernel 2.6.15-20060105152643-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 08:28:33PM +0100, Arjan van de Ven wrote:
> On Fri, 2006-01-06 at 20:21 +0100, Adrian Bunk wrote:
> > This patch removes the obsolete drivers/net/tulip/xircom_tulip_cb.c 
> > driver.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> 
> NACK... xircom_cb (while written by me and thus purrrrrfect, doesn't
> work for everyone). This chip is so f*cked up that it may not even be
> possible to get all the variants working with only 1 driver ;-(

It is even more funny: i discovered that it depends on the type of 
ethernet switch to determine which driver i have to use.

- extreme Summit48 _or_ crossover cable to some onboard via rhine:
  xircom_tulip_cb
- el-cheapo mini-switch, probably realtek inside:
  xircom_cb

and yes, i tried all different autonegotiation settings etc (with
xircom_tulip_cb at least since xircom_cb seems to lack ethtool support).

It also seems to additionally depend on which machine i put these cards
into and of course on the chip revision and the phase of the moon.

If i ever figure out a pattern, i'll file a bug.
For now i changed to a machine with a decent built-in card instead of
rtl8169 crap (which forced me to pull out the xircom cards again).

And "not working" was of course not "not working at all" but "works
somehow but with inferior performance" for both drivers.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
