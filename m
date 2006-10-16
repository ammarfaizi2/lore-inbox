Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWJPKUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWJPKUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWJPKUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:20:05 -0400
Received: from mx.go2.pl ([193.17.41.41]:40654 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1030224AbWJPKUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:20:03 -0400
Date: Mon, 16 Oct 2006 12:25:00 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: David Johnson <dj@david-web.co.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: Hardware bug or kernel bug?
Message-ID: <20061016102500.GA1709@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	David Johnson <dj@david-web.co.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20061013085605.GA1690@ff.dom.local> <200610131256.54546.dj@david-web.co.uk> <20061013130648.GC1690@ff.dom.local> <200610131724.40631.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610131724.40631.dj@david-web.co.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 05:24:39PM +0100, David Johnson wrote:
> On Friday 13 October 2006 14:06, Jarek Poplawski wrote:
> >
> > Probably - but only with networking. So I'd try with this debugging
> > like in my first reply plus maybe 2.6.19-rc1 (e1000 - btw. I hope
> > this other tested card was different model - and locking improved)
> > and resend conclusions to netdev@vger.kernel.org.
> >
> 
> OK I built a 2.6.19-rc1 kernel with a minimal config as you describe and I 
> cannot reproduce the reboots with this kernel. My .config:
> http://www.david-web.co.uk/download/config

I've seen more minimal minimal configs but if it works
it is 50% of success. 

> The other NIC I tried was a D-Link DL10050-based card which I think uses the 
> dl2k module.
> 
> I tried to reproduce the problem under Windows (2k), which didn't reboot but 
> did still suffer from it I believe. Randomly during an scp transfer (using 
> the PuTTY scp client) Windows will lock-up for about 30 seconds, making an 
> entry in the event log indicating that there was a time-out talking to the 
> IDE controller, then continuing. Could the same thing be happening in Linux? 
> If Linux can't talk to the IDE controller when trying to write to disk, how 
> does it handle that?

Was this lock-up effect visible during above 2.6.19-rc1 tests?
If not I'd try to continue linux debbuging:
- is 2.6.19-rc1 working with "normal" config (use make oldconfig
to "upgrade" .config),
- is 2.6.17 working with "minimal" config (use make oldconfig),
- changing one or two options at a time try to find which one makes
the effect returns (acpi, smp...). 

Regards,
Jarek P.

PS: Sorry for late reply - I was offline.
