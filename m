Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264103AbRFXKhh>; Sun, 24 Jun 2001 06:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbRFXKh2>; Sun, 24 Jun 2001 06:37:28 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:7940 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S264103AbRFXKhV>;
	Sun, 24 Jun 2001 06:37:21 -0400
Message-ID: <3B35C2FA.37F57964@bigfoot.com>
Date: Sun, 24 Jun 2001 04:37:46 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: klink@clouddancer.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Annoying kernel behaviour
In-Reply-To: <3B33EFC0.D9C930D5@bigfoot.com> <9h0r6s$fe7$1@ns1.clouddancer.com> <20010623090542.6019D7846F@mail.clouddancer.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colonel wrote:
> Look in the people/mingo directory for a patch

The patch did not work.
 
> I have:
> 
> Linux video capture interface: v1.00
> bttv: driver version 0.7.63 loaded
> bttv: using 2 buffers with 2080k (4160k total) for capture
> bttv: Host bridge needs ETBF enabled.
> bttv: Bt8xx card found (0).
> bttv0: Bt878 (rev 2) at 00:0b.0, irq: 10, latency: 32, memory: 0xe3000000
> bttv0: subsystem: 144f:3000  =>  TView 99 (CPH063)  =>  card=38
> bttv0: model: BT878(TView99 CPH063) [autodetected]
> bttv0: enabling ETBF (430FX/VP3 compatibilty)
> i2c-core.o: adapter bt848 #0 registered as adapter 0.

Linux video capture interface: v1.00
bttv: driver version 0.7.57 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Bt8xx card found (0).
bttv0: Bt848 (rev 18) at 00:0f.0, irq: 10, latency: 64, memory: 0xd79ff000
bttv0: model: BT848A( *** UNKNOWN *** ) [autodetected]
i2c-dev.o: Registered 'bt848 #0' as minor 0
i2c-core.o: adapter bt848 #0 registered as adapter 0.

 ** ^^ this worked in 2.2.19 as 
bttv0: Brooktree Bt848 (rev 18) bus: 0, devfn: 88, irq: 11, memory:
0xe4102000.
bttv: 1 Bt8xx card(s) found.
bttv0: NO fader chip: TEA6300
bttv0: model: BT848(Miro)

Sigh..  I'll try the update.
 
> Bttv-0.7.63-2.4.3.patch.bz2
> 
> from the website.  Video4linux has always worked in the various 2.4
> kernels I've tried.
> 
> >and accesing mod_video, the box locked up hard (not even sysrq worked).  And
> 
> I don't run mod_video, but xawtv works fine.  Did you try that or
> rebuilding mod_video?

It shouldn't matter, as userspace programs should not be able te fuck te
kernel over in such a complete instant deadlock.  There is something
seriously rotten with video4linux or the driver if my little userspace app
can take out machines with no warnings and no error messages on conesole/in
logs.

Recompiling didn't affect it, either.

 
> >when I rebooted, I found that some files is /etc were eaten -- even though
> 
> You must have grues.

No, the sync writes seem broken in 2.4.5.  That is very bad.

--
    www.kuro5hin.org -- technology and culture, from the trenches.
