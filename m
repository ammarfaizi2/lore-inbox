Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHLOU>; Thu, 8 Feb 2001 06:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBHLOJ>; Thu, 8 Feb 2001 06:14:09 -0500
Received: from [202.212.27.182] ([202.212.27.182]:4360 "HELO antiopikon")
	by vger.kernel.org with SMTP id <S129032AbRBHLNz>;
	Thu, 8 Feb 2001 06:13:55 -0500
Date: Thu, 8 Feb 2001 20:15:39 +0900
From: Augustin Vidovic <vido@ldh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
Message-ID: <20010208201539.A19229@ldh.org>
Reply-To: vido@ldh.org
In-Reply-To: <20010208194156.A19161@ldh.org> <200102081100.f18B0Am17975@moisil.dev.hydraweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102081100.f18B0Am17975@moisil.dev.hydraweb.com>; from ionut@moisil.cs.columbia.edu on Thu, Feb 08, 2001 at 03:00:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 03:00:10AM -0800, Ion Badulescu wrote:
> > At the same time, the /var/log/messages receives thousands of messages from the
> > NET: subsystem.
> 
> So what _were_ those messages? Can you post them?

No I can't because they were suppressed by the syslogd (DOS protection), only
their number being reported (several thousands every few seconds).

> > Since the dmesg of the kernel tells about a work-around for such a bug, I was assuming
> > that the work around was activated, but I had a doubt and after looking at the source,
> > I discovered that it wasn't.
> 
> Well, your patch disables the work-around exactly for those (really old) cards
> that actually need it and enables it for those that don't need it.

No, because the test usede for the activation is now the same as the one used
for the diagnostic, which means that every card which is diagnosed to have the
bug get the workaround activated.

> > Now, as Ion says, maybe it is not the "receiver lock-up bug" itself which is
> > worked-around, frankly I don't know.
> 
> eth0: Sending a multicast list set command from a timer routine........."
> 
> If you find such messages, the work-around really did something. Otherwise,
> it's the placebo effect...

Now, I do not get _any_ message in the logs, which means that the network
cards activity is closer to normality than before the patch.

-- 
Augustin Vidovic                   http://www.vidovic.org/augustin/
"Nous sommes tous quelque chose de naissance, musicien ou assassin,
 mais il faut apprendre le maniement de la harpe ou du couteau."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
