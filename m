Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVHDPVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVHDPVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVHDPTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:19:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42444 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262577AbVHDPTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:19:07 -0400
Date: Thu, 4 Aug 2005 17:19:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, ak@suse.de
Subject: Re: [RFC] AMD64 @ K8T800/VT8237: Doubled IOAPIC-level-interrupt rate
Message-ID: <20050804151911.GA20765@elte.hu>
References: <200508041625.41296.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508041625.41296.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Hi,
> 
> this should likely be addressed to VIA Taiwan,
> but I don't know their engineer's e-mail address and their forum
> doesn't work for me.
> Maybe somebody here has a clue?
> Or maybe this is even motherboard specific?
> 
> To reproduce:
> 	$ aplay -Dhw:0 -fdat /dev/zero
> 
> On a sane system (or here in PIC Mode) you'll see
> around 12 Interrupts/s.
> Here I see 24.

i think this is an effect of the 'POST-flush' symptom: the IO-APIC write 
of unmasking the IRQ does not reach the chipset before the ACK via the 
local-APIC does. Does it work fine if you artificially read after the 
IO-APIC write?

	Ingo
