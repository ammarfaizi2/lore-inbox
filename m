Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVJMXDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVJMXDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVJMXDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:03:01 -0400
Received: from tim.rpsys.net ([194.106.48.114]:58530 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932182AbVJMXDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:03:00 -0400
Subject: Re: spitz (zaurus sl-c3000) support
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: lenz@cs.wisc.edu, zaurus@orca.cx,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051013224419.GF1876@elf.ucw.cz>
References: <20051012223036.GA3610@elf.ucw.cz>
	 <1129158864.8340.20.camel@localhost.localdomain>
	 <20051012233917.GA2890@elf.ucw.cz>
	 <1129192418.8238.21.camel@localhost.localdomain>
	 <20051013224419.GF1876@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 00:02:26 +0100
Message-Id: <1129244547.8238.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-14 at 00:44 +0200, Pavel Machek wrote:
> Thanks. Kernel works, even with 3.5.3 opie. [But touchscreen gets
> extremely interesting, you have to click top-right corner to get it to
> register click in bottom-left].

Yes, there's a bug in the opie (qte specifically) calibration code which
is fixed in 3.5.4 (I fixed it). I ended up replacing qte's algorithm
with a decent 5 point one.

> > Rename the gpe or opie file "hdimage1.tgz" to flash depending on what
> > flavoured image you'd like. You need the other files including gnu-tar.
> > You don't need an initrd.bin file as under 2.6 we can boot directly from
> > the microdrive.
> 
> You mean I should place tar binary on flashcard, because updater.sh
> needs it? [What is updater.sh anyway, xor 0x5e encrypted shell
> script?!]

Yes, place the file as gnu.tar on the flashcard with updater.sh.
updater.sh is indeed an "encrypted" shell script! There are tools around
to decode/encode it.

> Oh, okay, one more question. Do you trust your battery charging code
> enough to leave spitz overnight in charger? I would hate to be awaken
> by angry lithium ;-).

My spitz has been left plugged in all the time with my charging code and
has yet to explode. ;-) Its very similar to the c7x0 code which people
have happily been using for a while in OpenZaurus c7x0 2.6. Spitz does
contain a charging chip which should prevent major damage to the
battery. The software just tries to help it along...

Cheers,

Richard

