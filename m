Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWEaOB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWEaOB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEaOBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:01:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48559 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965033AbWEaOBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:01:34 -0400
Date: Wed, 31 May 2006 10:01:18 -0400
From: Alan Cox <alan@redhat.com>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: Michael Hunold <hunold@linuxtv.org>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org, Nathan Laredo <laredo@gnu.org>,
       Christer Weinigel <christer@weinigel.se>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [v4l-dvb-maintainer] Re: Stradis driver conflicts with all	other SAA7146 drivers
Message-ID: <20060531140118.GE26681@devserv.devel.redhat.com>
References: <44799D24.7050301@gmail.com> <1148825088.1170.45.camel@praia> <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com> <1148837483.1170.65.camel@praia> <m3k686hvzi.fsf@zoo.weinigel.se> <1148841654.1170.70.camel@praia> <447AED3B.4070708@linuxtv.org> <1148909606.1170.94.camel@praia> <447AFA88.1010700@linuxtv.org> <1148911139.1170.99.camel@praia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148911139.1170.99.camel@praia>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 10:58:59AM -0300, Mauro Carvalho Chehab wrote:
> 1) Integrate your code and Nathan one;
> 
> 2) create a generic handler for all saa7146 boards, moving all PCI probe
> to the newer module. After detecting the card number, it should request
> the specific module.

#2 breaks some existing setups that build modules to load based on the PCI
tables or built initrds this way. You can have two drivers for the same
PCI identifier providing that they both know how to bail out for the wrong
type of card
