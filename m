Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422627AbWKHTeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422627AbWKHTeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161727AbWKHTeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:34:50 -0500
Received: from www.osadl.org ([213.239.205.134]:36576 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161725AbWKHTet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:34:49 -0500
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required)
	[2.6.18-rc4-mm1]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061107222711.GA22612@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
	 <1162830033.4715.201.camel@localhost.localdomain>
	 <20061106205825.GA26755@rhlx01.hs-esslingen.de>
	 <200611070141.16593.len.brown@intel.com> <20061107080733.GB9910@elte.hu>
	 <1162887935.4715.349.camel@localhost.localdomain>
	 <20061107091628.GA5399@rhlx01.hs-esslingen.de>
	 <1162891737.4715.354.camel@localhost.localdomain>
	 <1162892758.4715.362.camel@localhost.localdomain>
	 <20061107222711.GA22612@rhlx01.hs-esslingen.de>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 20:36:59 +0100
Message-Id: <1163014620.8335.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 23:27 +0100, Andreas Mohr wrote:
> I applied the patch, the changes *are* in the tree and I did create and
> install a new image (with CONFIG_NO_HZ re-enabled and C1 hard-wiring removed),
> but it failed again, completely. The usual hang during boot with
> keyboard activity required, and then it didn't even manage to finish booting
> (I probably was too slow in generating the necessary amount of events).
> 
> Let me think a bit about that stuff, maybe I'll be able to figure out what's
> happening on my system. Or any other ideas?
> (since I would like to somehow get this resolved without less than perfect
> workarounds if possible)

Yes, I'm going to drop the detection as it can never be perfect and
enforce the PIT usage on UP boxen, as it seems that the lapic / BIOS
crap is more or less unfixable. Working on a patch against rc5-mm1 right
now.

	tglx


