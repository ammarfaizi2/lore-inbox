Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTE0Rjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTE0Riz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:38:55 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:9912 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263979AbTE0RiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:38:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16083.42349.964658.11555@gargle.gargle.HOWL>
Date: Tue, 27 May 2003 13:50:37 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: John Stoffel <stoffel@lucent.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
In-Reply-To: <20030527164300.GL8978@holomorphy.com>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
	<200305271048.36495.devilkin-lkml@blindguardian.org>
	<20030527130515.GH8978@holomorphy.com>
	<200305271729.49047.devilkin-lkml@blindguardian.org>
	<20030527153619.GJ8978@holomorphy.com>
	<16083.35048.737099.575241@gargle.gargle.HOWL>
	<20030527155259.GK8978@holomorphy.com>
	<16083.37850.528654.94908@gargle.gargle.HOWL>
	<20030527164300.GL8978@holomorphy.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Lee Irwin <wli@holomorphy.com> writes:

William> "William" == William Lee Irwin <wli@holomorphy.com> writes:
William> If you don't know, then just hit "enter".

William> On Tue, May 27, 2003 at 12:35:38PM -0400, John Stoffel wrote:
>> Sure, I understand that, but what I'm really complaining about is the
>> text of the prompt.  When I do a 'make menuconfig' it's alot cleaner
>> and more understandable what's happening here.
>> Part of the problem is the specification in arch/i386/Kconfig, which I
>> think needs to be re-worked.  
>> In my case, I specified that the max number of CPUS is 2, since I only
>> have a dual CPU box.  So it's not a BIGCPU box.  Not sure how to make
>> this change... I'll have to find some time and play with this.

William> CONFIG_NR_CPUS should appear under the processor type and
William> features menu.

I must not have been clear enough in my rant, so let me rephrase it.  

Because I had already configured NR_CPUS=2, I'm not sure that I should
have even gotten the choice of X86_BIGSMP at all, since it's obviously
not valid in this case.

I'm really asking for the configuration specifications and
dependencies to be cleaned up, and maybe I'll try to do it myself and
send in the patch.  Right now I'm going to be trying 2.5.70-mm1 with a
patch for my ISA Cyclades board first.

So the real thrust of my posts before was:


The language and description used when running 'make oldconfig' and
trying to set the "X86_GENERICARCH" option is ugly and hard to
understand and doesn't match how it's shown in the 'make menuconfig'
settings.  

Sure, I realize that oldconfig is more a helper than a real
interface, but it still has warts that I'd like to fix or have
someone else fix if I can't do it myself.

Maybe the entire issue is really how do you do specify and constrain
inputs properly in this setup?

John
