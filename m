Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030881AbWKOTBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030881AbWKOTBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030882AbWKOTBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:01:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5516 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030881AbWKOTBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:01:37 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Takashi Iwai <tiwai@suse.de>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611151046410.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	 <20061114.190036.30187059.davem@davemloft.net>
	 <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	 <20061114.192117.112621278.davem@davemloft.net>
	 <s5hbqn99f2v.wl%tiwai@suse.de>
	 <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org>
	 <1163607889.31358.132.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0611150829460.3349@woody.osdl.org>
	 <455B5F01.7020601@garzik.org>
	 <Pine.LNX.4.64.0611151046410.3349@woody.osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 20:01:18 +0100
Message-Id: <1163617278.31358.149.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 10:51 -0800, Linus Torvalds wrote:
> So I think it's either: (a) irqbalance doesn't balance MSI interrupts at 
> all or (b) the MSI interrupt code doesn't honor balancing requests even if 
> it does.

it's (A) right now for sure for irqbalanced at least.

> The suspend problem reported by Stephen is another such thing - where MSI 
> itself wasn't a problem, but stupid (probably broken) firmware code at 
> wakeup broke it by an unforseen interaction. Again, that is probably 
> related to the fact that nobody has ever really tested it (ie firmware 
> "engineers" obviously didn't actually ever test anything with MSI enabled 
> and in use, and there really is no excuse for firmware messing with the 
> MSI setting - other than the usual "firmware is inevitably buggy" thing).

ok so maybe this should be in the linux firmware kit.. it has
suspend/resume tests after all ;)

if there is a "do this then this to reproduce" scenario it's even likely
it's trivial to put into a testcase...

> 
> 			Linus
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

