Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272341AbRIWRP4>; Sun, 23 Sep 2001 13:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272369AbRIWRPq>; Sun, 23 Sep 2001 13:15:46 -0400
Received: from femail20.sdc1.sfba.home.com ([24.0.95.129]:17589 "EHLO
	femail20.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272341AbRIWRP3>; Sun, 23 Sep 2001 13:15:29 -0400
Date: Sun, 23 Sep 2001 13:17:39 -0400
From: Gordon Tyler <gordon@doxxx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@redhat.com>
Subject: [PATCH] devfs support for raw char device, kernel 2.4.9
Message-ID: <20010923131739.A1700@puchiko.doxxx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm not subscribed to the linux-kernel list so please CC me on any replies.

This is a patch to kernel 2.4.9 for adding devfs support to the raw char device
(drivers/char/raw.c). It registers the rawctl device, the raw subdirectory and
a configurable (max_raw kernel param) number of raw/rawX devices. I've done
some basic empirical testing on my changes and it seems to be working okay. I
haven't tested it for compatibility with a non-devfs system since I don't have
one.

There are two further modifications I would like to make. First, make it a
module so that it can be loaded at runtime and thus configured at runtime
without having to add a kernel parameter to LILO or whatever. Second, change
the control interface to kernel functions (ala loopback device) rather than
ioctl on a control device which seems a bit grungy to me. This second change
would require changing the userspace configuration utility as well and is not
as "trivial" as the first.

Ciao,
Gordon

--HcAYCG3uE/tztfnV
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="raw_devfs_patch.tar.gz"
Content-Transfer-Encoding: base64

H4sIAKYTrjsAA+1XbU/jRhDma/IrRqm4c7Dj2A4OlAAiPQLlyksVoJx0PVmOvSF7+CXy2hBa
+O+d3bVDSODgKtGqqh9FxNmdmZ3XZ02/19096i29KQzTMNqrq0uGYZhrtjH7LWDarSVjrWW3
Vk2j1VpDebNl2EtgvK1bEhlL3QRg6TJO/Dh6Xu6l/f8ofnVTbwRpDK7vg0+uhwxYNh7HScoX
0xGBxL0Bb4Q5wl3qEVD8hF6ThDX5YhN3da+uweAW9kWG4Ow2IAlsynzt+PFkMtEjkm5X/+1Q
SzwBrJ8jyu6MeSe8yRkvzD/OvVXMv9luoZzZss1y/v8RNBoNCGiUTRqWvqr/2Fwc7soF8eFj
FoG1BpaxYRobto0PhllVVRWuSBKRoMHiLPHI8zZOUf+UjMFqgWlt2NZGy5I2dnagsa61QV3X
zFXY2akCrBRM4yYEMoanIxMNaOQLOorxTwIhjeIEoiwc4EFiP4i9q1yR6dxKswpVtblSVdHg
h5EbXRK2IX6IP6Yt/UEfAF6kLq4B0ICu75M5mtShTy4pS7kfGKuXBpqgTJYNfJoQL42TW3DR
eVzkyfiUGwNwPQ8PotEl9z90Jw5XQy9oRFOdSzWrahV+oJEXZD6BTVGm5pDpo+3FZRoPsuGT
O6H7NU74Dk+12ea5tla1NZHreVnPHbsDGtD09klTLBw7PM9zmy4LmxlGQ5jwTV3wjQfEVVDJ
J0MaEfDHCY3SK2Wi63od14Vz1hq6pbbammkI7yosTTIvBUZCdzyKsRvCLCWTThXuIectrLbj
u6nrpB1ebpzllHqYwXSa0C1Yx618Y0FrZoV9tuz2l87UiGRFbBw/IFIQa+vMrn5Ldk4Qpi4w
Rv8QMjdOLqZwd5MbDfJwhzQgsKLJSxe/pYIGQTwcouJKvZPny25p2MZq29baspwz4TsOz7rw
hD8o1zH161X4E7PKt2mn2qgkeeM63ijhfvS7F85R9+NJX4MaKtY0eMf1h/GY4ZmNqlrBT164
X3r9Y2e399P5vpDdEF1L3YAybOjfoxoqCHE6BEUparEJZh3u7mC6sA2Wbdfr6JZaeWT5ots/
Pjh+sH2Nlv1pTZUQWRsGBD/pDSFRjatXKnyoamCKaeN2NWQPPl7Yc24WpKCs1wvPKo/aQ63c
46g9H1uRKG5MjNPsC1Fhkkcqi/49eX0x9ixyB9gPSBGF2UUXYNlHLzSYHiRjTEiaJRE0egcn
3xej7PW5+J4YAMweP+dx1Mrx+eGhjBTl0avd3m97p87eIR631z0/PJvxUwNDE7U7dQ72Pvzc
hzvAp/75/ol8ujg/7efZ4mfzjGnA7RftNT9p6JH8GV45SL8zvtRmFHmpFjW3pMDrCxK6V2R6
Gcyw/XuUez/ttL9dheVMXCQ5O4kC510rDA+xBxSKAZsdoLC5VWziL1XNoxA9Erkh+WwKaqtU
mDh5qPBFmZjlDA1T6etcJedzpIFUEyX7ZllpLvRyXedqes/rCg/BGSI4HOe2jAv3KpxqnKPz
s94n5d0sf9MvurggBEFCkXiD3xe40JCU6LlBoBS0yI/kzCh4kkymPKny7MnIs+jZdBRN+JTg
/KjM8uG8/HM8Ua+/thMfbL2SHEQXhrGf4X0l7ofZjOTrIh9FYvj6o/s1v2DypnMYJnusyCsL
77E8hQ8sy2g4Rpu4lcaBgl+y5kgAklxkrczCNSc3WMstbD00v9yRNW7i2xx/YTwZk6jpBTEj
4MX44sHbh597cKKX/3aWKFGiRIkSJUqUKFGiRIkSJUqUKFGiRIn/If4ChJ1ZvgAoAAA=

--HcAYCG3uE/tztfnV--
