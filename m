Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbTDQOjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTDQOjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:39:46 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:17389 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261341AbTDQOjl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:39:41 -0400
Date: Thu, 17 Apr 2003 17:03:21 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Antonio Vargas <wind@cocodriloo.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RedHat 9 and 2.5.x support
Message-ID: <20030417150321.GC16335@wind.cocodriloo.com>
References: <20030416165408.GD30098@wind.cocodriloo.com> <1050517953.598.16.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050517953.598.16.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 08:32:34PM +0200, Felipe Alfaro Solana wrote:
> On Wed, 2003-04-16 at 18:54, Antonio Vargas wrote:
> > I've just installed RedHat 9 on my desktop machine and I'd like
> > if it will support running under 2.5.65+ instead of his usual
> > 2.4.19+.
> 
> I'm running on RHL 9 with 2.5.67-mm3 (plus Russell King PCMCIA/CardBus
> patches) and updated modutils + procutils + nfs-utils. It works
> flawlessly, although I needed some tweaking for "/etc/init.d/rc.sysinit"
> which insists in setting the module and hotplug helper binaries to
> "/sbin/true" due to missing "/proc/ksyms".

I managed to avoid some of these things:

1. I compiled everything in-kernel and disabled modules, thus no modules
   related problems (*)

2. RH9 procutils _seems_ to work fine: I can do "vmstat 1" whereas the older
   gentoo image from summer I used to test boot 2.5 didn't.


(*) RH9 detected my elitegroup motherboard integrated sound and unsed the i810
    module, but now with everything in it seems I can't have sound any ideas?
    Hmm, yes I _did_ compile i810 support in-kernel ;)

I'm also having another problem: gnome-terminal is freaking out when i run
"make menuconfig" on it, very strange....
