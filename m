Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTJQLKi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTJQLKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:10:38 -0400
Received: from a205017.upc-a.chello.nl ([62.163.205.17]:7552 "EHLO
	mail.fluido.as") by vger.kernel.org with ESMTP id S263383AbTJQLKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:10:31 -0400
Date: Fri, 17 Oct 2003 13:10:32 +0200
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031017111032.GB1639@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston> <20031016101905.GA7454@casa.fluido.as> <1066300935.646.136.camel@gaston> <20031017100412.GA1639@casa.fluido.as> <1066387778.661.226.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066387778.661.226.camel@gaston>
X-operating-system: Linux casa 2.6.0-test7-radeon
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
	Date: ven, ott 17, 2003 at 12:49:38 +0200

Quoting Benjamin Herrenschmidt (benh@kernel.crashing.org):

> Not sure what's up here. The driver is quite passive regarding
> the mode for other VCs, it sort of expect the fbcon layer do pick up
> the default mode and use it for other consoles. I'm not sure what's
> wrong here.
> 
> In a more general way, I really lack the ability to change the console
> size with fbset like I could do with 2.4. I don't know if James revived
> that feature in his latest patches though. The stty thing isn't very
> reliable imho. Especially on monitors that don't like the standard
> modedb.

fbset really does a great mess, if mixed up with stty. It took me
almost an hour to find the right combination. Now, I have a stable
system, apart from the fact of having to do blind termnal setup for
each VC...

> > And on a similar topic, could you write a couple of examples about how
> > to use the parameters included in radeon_base.c? I am thinking
> > especially of the "mirror" and "monitor_layout" parameters, that I
> > believe would allow me to use the two or three video outputs of the
> > card independently. I currently read
> 
> I have to see what I'll do of these parameters first. For now, the
> driver only really use the first head. I haven't yet implemented support
> for the second one, though it's on my list of things to do.

Aha... So, from what you know, is there any possibility (fb, X, X with
ATI drivers, anything else) to use the video output (or the second
head) of radeon cards under Linux? And have you tried your drivers
with 2 cards (one PCI and one AGP)?

And in all cases, why is parameter "mode" not working? If I could set
1280x1024-32@60 from Lilo, most of my problems would be solved...

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
