Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTLOJTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 04:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTLOJTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 04:19:54 -0500
Received: from [62.12.131.37] ([62.12.131.37]:61625 "HELO debian")
	by vger.kernel.org with SMTP id S263441AbTLOJTw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 04:19:52 -0500
Date: Mon, 15 Dec 2003 10:13:07 +0100
From: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: alsa on gentoo ppc 2.6.0-test11-benh1
Message-Id: <20031215101307.5fa979c1.zdavatz@ywesee.com>
In-Reply-To: <1071474131.12496.411.camel@gaston>
References: <20031212083609.6db56e5b.zdavatz@ywesee.com>
	<1071474131.12496.411.camel@gaston>
Organization: ywesee - intellectual capital connected
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Ok, great. CapsLock works!
2. amixer and alsamixer now also seem to work. I get a reasonable result when I do amixer or alsamixer.

But now my speaker complains: can not open /dev/sound/mixer.

Any hints?

Thanks for your feedback.

Zeno


On Mon, 15 Dec 2003 18:42:12 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > soundcore              11200  3 snd,dmasound_core
> > 
> > When I do amixer I get:
> > amixer: Mixer attach default error: No such device
> > 
> > I done my kernel with make menuconfig, make, make modules_install
> > 
> > I have been searching the Net for clues but did not find anything so far, to get my sound working.
> 
> It seems you are trying to load both dmasound_pmac and alsa
> snd-powermac, they are mutually exclusive.
>  
> 
> > 2. Why does my computer go to sleep when I press 'CapsLook'. Can I turn
> > that off or is this still a 2.6.0 Bug?
> 
> That's a strange thing that appeared with one snapshot of test11
> and disappeared with the next one afaik. I don't have a good explanation. It
> definitely doesn't happen on my laptops, and the logs I got from users seemed
> to indicate that the PMU chip (which controls the keyboard on those laptops)
> was actually the one sending a spurrious 0x7f event (power key). It may be
> something we do that triggers that though I haven't been able to find out
> what.
> 
> If it happens reproduceably, you may want to disable whatever userland
> daemon you have that triggers sleep when you press the power key. (I
> suppose pbbuttonsd).
> 
> Ben.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Mit freundlichen Grüssen / best regards

Zeno Davatz
Verkauf & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.oddb.org
