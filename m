Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLFUaz>; Wed, 6 Dec 2000 15:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbQLFUap>; Wed, 6 Dec 2000 15:30:45 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:32015 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S129431AbQLFUa3>; Wed, 6 Dec 2000 15:30:29 -0500
Date: Wed, 6 Dec 2000 15:00:38 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: Pete Zaitcev <zaitcev@metabyte.com>
cc: <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>
Subject: Re: YMF PCI - thanks, glitches, patches (fwd)
In-Reply-To: <200012061902.LAA21377@ns1.metabyte.com>
Message-ID: <Pine.LNX.4.30.0012061423450.3758-101000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="839566344-332498274-976131129=:3758"
Content-ID: <Pine.LNX.4.30.0012061432230.3758@fonzie.nine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--839566344-332498274-976131129=:3758
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0012061432231.3758@fonzie.nine.com>

On Wed, 6 Dec 2000, Pete Zaitcev wrote:

> > Date: Wed, 6 Dec 2000 13:12:13 -0500 (EST)
> > From: Pavel Roskin <proski@gnu.org>
> > cc: Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@metabyte.com>,
> >         <peter@cadcamlab.org>, <kai@thphy.uni-duesseldorf.de>
>
> > The native YMF PCI driver from Linux-2.4.0-test12-pre5 works on my card:
>
> I did not have a chance to look at whatever is in 2.4, but from
> reading Linus's e-mails I understand that Jaroslav made a new
> port, which is probably unrelated to the stuff that I hastily
> cooked up for 2.2 (I really wanted to play Doom on my new Sony).

:-)))

> I am sorry for the lack of communication.

Why sorry? Do you mean that the linux-sound list is not dead and you saw
my message there?

> I'll see what 2.2 does about 1) playing at 5512 Hz, 2) compiling
> as modules together (non-modules are made to be exclusive),
> 3) compiling if CONFIG_PCI is not enabled, 4) has Configure.help
> update.
>
> I am not sure what to do about CONFIG_EXPERIMENTAL.
> My current plan is to discard "(EXPERIMENTAL)" and forget
> about it until the next case.

But please note that opl3 is not enabled by the new driver, so people do
lose some functionality they used to have.

> Ioctl 0x5401 is a mystery. I do not know what it is
> (looks like SNDCTL_TMR_TIMEBASE without uppper bits).

It is caused by an attempt to play at 5512 Hz. In fact, this time (I've
upgraded to test12-pre6 in the meantime) it hung very badly, so that even
"kill -KILL" doesn't help:

 3786 pts/3    D      0:00 sox spinout.wav -t ossdsp /dev/dsp

sox-12.16-7, RedHat 6.2. The same with sox-12.17.1. The later uses
SNDCTL_DSP_SPEED to set the rate, but still the message about ioctl 0x5401
appears in the log.

> Please send fewer attachements to the lists. Your sound fragment
> is very useful, but I'd prefer to have it sent separately to me
> upon a request (in uuencode :).

Sorry :-(

> BTW, Legacy driver (ymf_sb) uses PC/DMA or whatever the name is,
> which requires the north bridge support and, sometimes, additional
> connections on the motherboard. This is not reflected in _any_
> kernel documentation. I have spent numerous hours trying to make
> it work on my laptop until I understood that even though my
> chipset supports PC/DMA, necessary connections are missing.
> At first glance, it looked as if IRQ does not come.

Maybe it explains why I'll have to reboot now to kill that "sox" :-/

Regards,
Pavel Roskin

--839566344-332498274-976131129=:3758
Content-Type: APPLICATION/X-GZIP; NAME="ymf.diff.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0012061432090.3758@fonzie.nine.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ymf.diff.gz"

H4sICC94LToAA3ltZi5kaWZmAL1Uf2vaUBT9e/kUZ1JoJcZGndY6BmZWh1Cr
VDuUMeQ1ec5A8p4kL6vu0+++qK3xR1nHGIQQ8u6955x7z32WZSHwRbK8vJFu
EnKhmPKluGxJMfN/JBEvznmweDdKOG64C1RRsht2vVGyUbZt2zBN8635V43q
VaNcW+c3m7BKH8pVu1CDuf4o1dFsGjAAdGdIRExVCojZCpMi/TYnLGRzhkGr
C0FgPzlC6XHEyWIhI4WL9njQvu/22ncj5zZvmK3+Xaf7ZTrsP9zdTCe9DuUZ
JjCa+zHoYQJ8ueCRn3IP4EVUMYKaM4Uk5jF24GKZCA8uizxKFbqKmvNdEkVM
ZIKQqLIglnhiQkFJqIh+CEnB0aZ+QSfndkoH/AdzVxklOdLupVQ4+sPhJjMu
GmamB0cyD0Tvad5oZNuPmYxOyUz7oJJI6E8eppplSmmYRn0OWKyohCvDBfXh
MdhthCfFuYLg3NNJXDA61hWyqdvBUQg1HL7SCuEQkdBf0vlF6Edy0OqVypf0
Ltt5Axl5FDntdcfte+0YnXbhJJ4v0ZJhyAinKwhlxlyeT+eNRSSVdGWg0VJi
xD1MhO8yxfHkq7lhPS/FpueXaUs2pi764sg+VPb34U9SaRWuGxX7ZRWurvUe
0Ps63YGZr/fA44upivxYaYLnwNeug3q5VavXsFXqcfc82xUKopjxeIyzzf/U
BP4M35A7O/RHDu8/IbfK4ftHPd7U3fvAb9q8PT7rzUMGOUvtuFjt/LUhCSsJ
eLxXV59nilKRzaVCTaQrpVpY3yc41POsqNNDvBIkO/Z/acdNepU62a0/uLUq
+a2+A0E6Jout2byORCUr1tApgaWTc6VQkQwCHu3Lojgd9nflywUMnUoB2v5D
Z4lHpq0+EIP1Vh/FOibFeg3rxOVz0KaDsWdmpkevYV4xJvlSvPhSB++z+tfG
TMWbJ1l1TuzL/+mWLqp35SharV618eDcj04A6KM05qixjN8rbTTHDwgAAA==
--839566344-332498274-976131129=:3758--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
