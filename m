Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbSJHSmV>; Tue, 8 Oct 2002 14:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbSJHSlI>; Tue, 8 Oct 2002 14:41:08 -0400
Received: from kim.it.uu.se ([130.238.12.178]:47801 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261455AbSJHSkY>;
	Tue, 8 Oct 2002 14:40:24 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15779.10216.623962.179406@kim.it.uu.se>
Date: Tue, 8 Oct 2002 20:46:00 +0200
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFT] 3c509-ethtool and then some, take 2
In-Reply-To: <Pine.LNX.4.44.0210072313050.24365-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0210072313050.24365-100000@montezuma.mastecende.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:
 > 	This should take care of it i think. From what you describe it 
 > looks like you're taking an interrupt right after we did a switch to 
 > window 4 when we do a spin_unlock_irq.
 > 
 > Mikael any testing is much appreciated, can you also try switching 
 > to full duplex?

Tested on a 3c509B combo TP/AUI PnP card. Status check didn't kill the link.
Switching to AUI and back to TP worked. Attempt to switch to 100Mbps gave an
error but had no ill effects. Switching to full duplex (talking to a 3c575_cb
over a crossover cable) worked, as did going back to half duplex.

But what's up with the driver date? October 16th is about a week in the future :-)

/Mikael

 > @@ -49,11 +49,13 @@
 >  			- Power Management support
 >  		v1.18c 1Mar2002 David Ruggiero <jdr@farfalle.com>
 >  			- Full duplex support
 > +		v1.19  16Oct2002 Zwane Mwaikambo <zwane@linuxpower.ca>
 > +			- Additional ethtool features
 >  */
 >  
 >  #define DRV_NAME	"3c509"
 > -#define DRV_VERSION	"1.18c"
 > -#define DRV_RELDATE	"1Mar2002"
 > +#define DRV_VERSION	"1.19"
 > +#define DRV_RELDATE	"16Oct2002"
