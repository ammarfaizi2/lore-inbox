Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbTE0Q36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbTE0Q36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:29:58 -0400
Received: from holomorphy.com ([66.224.33.161]:55527 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263931AbTE0Q35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:29:57 -0400
Date: Tue, 27 May 2003 09:43:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Stoffel <stoffel@lucent.com>
Cc: DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <20030527164300.GL8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Stoffel <stoffel@lucent.com>,
	DevilKin-LKML <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <20030527155259.GK8978@holomorphy.com> <16083.37850.528654.94908@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16083.37850.528654.94908@gargle.gargle.HOWL>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"William" == William Lee Irwin <wli@holomorphy.com> writes:
William> If you don't know, then just hit "enter".

On Tue, May 27, 2003 at 12:35:38PM -0400, John Stoffel wrote:
> Sure, I understand that, but what I'm really complaining about is the
> text of the prompt.  When I do a 'make menuconfig' it's alot cleaner
> and more understandable what's happening here.
> Part of the problem is the specification in arch/i386/Kconfig, which I
> think needs to be re-worked.  
> In my case, I specified that the max number of CPUS is 2, since I only
> have a dual CPU box.  So it's not a BIGCPU box.  Not sure how to make
> this change... I'll have to find some time and play with this.

CONFIG_NR_CPUS should appear under the processor type and features menu.
I fixed sparse physical APIC ID wakeup, so setting it to 2 should be
fine now. If the configurator is hiding it from you, please contact
Roman Zippel, and in the meantime vi .config and search for NR_CPUS and
set that to the desired value. AFAIK the option is visible, but I've
not got unusual configs.


"William" == William Lee Irwin <wli@holomorphy.com> writes:
William> Yes, they're mutually exclusive. You can't build one that
William> will run on all those machines because the programming isn't
William> done right for that.  But the generic architecture option
William> will run on at least 3.

On Tue, May 27, 2003 at 12:35:38PM -0400, John Stoffel wrote:
> I see that when I dod the menuconfig, it's not clear at all when
> running oldconfig.

make oldconfig is not meant for those in need of explanations. It's
barely meant to be interactive if at all. menuconfig might be a better
configuration method for you.


-- wli
