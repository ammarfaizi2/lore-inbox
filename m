Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbRFNMsA>; Thu, 14 Jun 2001 08:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262445AbRFNMru>; Thu, 14 Jun 2001 08:47:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62349 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262406AbRFNMro>;
	Thu, 14 Jun 2001 08:47:44 -0400
Message-ID: <3B28B267.A81B5A08@mandrakesoft.com>
Date: Thu, 14 Jun 2001 08:47:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochel@transmeta.com>
Cc: Jeff Golds <jgolds@resilience.com>, Keith Owens <kaos@ocs.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.6-pre3
In-Reply-To: <Pine.LNX.4.10.10106132305450.1433-100000@nobelium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> First off, the patch went into a pre-release of the kernel. Never would I
> trust a pre-release to be stable. Other issues with stability should be
> addressed through appropriate channels, not piggy-backing on another rant.
[...]
> This change was relatively minor, and easy to remedy the warnings before
> the next _stable_ version of the kernel was released. Plus, it will
> benefit everyone, anyway, in the end (hopefully).

You are totally missing the point.

First of all, I agree with the change (not surprising eh?), but the
other posters are definitely right.  If you are in a stable series,
having a patch arrive in a pre-release is totally immaterial.  A stable
series is a stable series.  API changes should be weighed far more
carefully than that.  You don't make changes just because there is
little existing breakage.  How do you know what you broke outside the
kernel tree?  Further, the change will might OOPS not just cause a
warning, if a driver is left in unmodified state.

And yes we need a feature macro too, as another poster mentioned.

I have converted the net drivers and ymfpci already to fix the
suspend/resume callbacks, and sent to Linus, so nobody needs to bother
with those.  Patches sent to Linus are archived at
ftp://ftp.us.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.6/

Anyway I beg you -- please consider API changes more carefully in the
future, even if Quick Draw Torvalds does not.  The changes that occured
here are immaterial:  the principle of the stable series is what is at
stake here.

Finally, when you modify drivers, please CC the maintainer.  ie. when
you patched eepro100, you should have CC'd Andrey Savochin.  Read
MAINTAINERS for an e-mail address, or the source code if not in
MAINTAINERS.

Regards,

	Jeff



-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
