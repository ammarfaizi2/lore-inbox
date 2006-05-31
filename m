Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWEaOaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWEaOaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWEaOaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:30:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28558 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965041AbWEaOaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:30:09 -0400
Subject: Re: [v4l-dvb-maintainer] Re: Stradis driver conflicts with
	all	other SAA7146 drivers
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       Michael Hunold <hunold@linuxtv.org>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org, Nathan Laredo <laredo@gnu.org>,
       Christer Weinigel <christer@weinigel.se>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
In-Reply-To: <20060531140118.GE26681@devserv.devel.redhat.com>
References: <44799D24.7050301@gmail.com> <1148825088.1170.45.camel@praia>
	 <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
	 <1148837483.1170.65.camel@praia> <m3k686hvzi.fsf@zoo.weinigel.se>
	 <1148841654.1170.70.camel@praia> <447AED3B.4070708@linuxtv.org>
	 <1148909606.1170.94.camel@praia> <447AFA88.1010700@linuxtv.org>
	 <1148911139.1170.99.camel@praia>
	 <20060531140118.GE26681@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 31 May 2006 16:29:56 +0200
Message-Id: <1149085796.3114.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 10:01 -0400, Alan Cox wrote:
> On Mon, May 29, 2006 at 10:58:59AM -0300, Mauro Carvalho Chehab wrote:
> > 1) Integrate your code and Nathan one;
> > 
> > 2) create a generic handler for all saa7146 boards, moving all PCI probe
> > to the newer module. After detecting the card number, it should request
> > the specific module.
> 
> #2 breaks some existing setups that build modules to load based on the PCI
> tables or built initrds this way. 

not if you make this meta module depend on the other two, that way all
this infrastructure will just pull the right stuff in.. at the price
of some wasted memory for the one you don't need

