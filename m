Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSF0LnA>; Thu, 27 Jun 2002 07:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSF0Lm7>; Thu, 27 Jun 2002 07:42:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:40584 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316789AbSF0Lm6>; Thu, 27 Jun 2002 07:42:58 -0400
Date: Thu, 27 Jun 2002 07:44:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Nicolas Bougues <nbougues-listes@axialys.net>,
       Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Problems with wait queues 
In-Reply-To: <2014.1025128170@redhat.com>
Message-ID: <Pine.LNX.3.95.1020627073831.4174A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1903068619-1025178248=:4174"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-1903068619-1025178248=:4174
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 26 Jun 2002, David Woodhouse wrote:

> 
> For the benefit of any newcomers to the list who haven't clocked RBJ yet...
> 
> root@chaos.analogic.com said:
> >  I am sure that you can have things look correct as well as run
> > properly. However, you didn't show us the code. You need to do
> > something like:
> 
> >             interruptible_sleep_on(&semaphore);
> 
> > while your wake-up occurs with:
> 
> >             wake_up_interruptible(&semaphore);
> 
> Do not ever use sleep_on() and friends. Almost all usage of these 
> functions will be buggy.
> 

Whatever your message means; perhaps it was a way of saying "Hello"
to an old friend?

Attached is a file showing about 485 usages of 'sleep_on' in the
kernel drivers. If this usage is, as you say, buggy then will you
please inform us unwashed hordes what we should use to replace these?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

--1678434306-1903068619-1025178248=:4174
Content-Type: APPLICATION/octet-stream; name="sleep_on.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1020627074408.4174B@chaos.analogic.com>
Content-Description: 

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
VL92SqMA5r82bXfOpFVMZ81L79y8VinEWCntS5Fc+5ZQ+1EYgOnJiLmZPxCw
yp8M2fPOQzHfLq4XUM2BaHY5eTbtqGtV5jhglogRbyXJ7OLZs+olN75LL++X
5VoRBXMxghFC3ZpHk/MJ9rhc9jhZSkS3PaKCvaGqTKcsbWtApvVvUKVyXOYf
HBnW+PiFLQzFUhCmVGtxuXnCcDp+WhVpSGiLSEPSo1/AdIWBRT+9sgNL2zyn
3OIw8PHplellWO4JedSjHWV3FZtaV0bzckWcaVCJgY+twjFDXeo2O5+V1a1G
ALSCUABxOiD7R5dBSGtWC5Gx2gecytV7+OF08wG2TvfCbECMMvG8J755Ulok
VzSyH54pVHZV/B2F6oKQ1rcd9waWQwgkVt0HPIxrkC5AxSLaxBZehXPIzXDM
Xbc8livFtAfhTgTxjbde1gnFZM71COTqokNMJEvOuIJIFksiFnxrew5AOQCn
wrIPAJsRC5T7ptEEDsHkbG6o7k3Z67qKG0iaRSR1ItQ0Tevsl2eM5UK5tWcQ
g4Ftpeffbj8ttUBc9+u/UvNEZZdfSXQzdxuNpuudfaa4U3+9G6f9ZITnl9PZ
eVeA8SdenJX3c5uZ5Zj2rii7li23z+2GzVsq87jWyGfNRSyCoH3m1YJ4fHpw
Z0dBCCdSSHxAggmmyvgcU7Qvt58cRAZ8tqGzlubW8I8idAhhKjGP7sdhKe/5
kwg0LKWiFzaFKyVyBX5TMyunbOTTGqB9YwVC+7rSG2D42b9h75BzGmJiuh+U
b/4qNVs+sOW65pkxuObljs62WRLFTPpmPIgXcLXTmt0wvjOVhamJfLHbvI+J
kFHWMrygk2dZ1lYyVeEibOwBL2MCjN8rDQDXlsaCtabtlNi2C9kDx+8SEbJV
t+3OVx9LFooV80S5fz9R8xHFoJtz5/be+Ml8p0vO4MLzzNn0vyYGvCDeXoJs
q6HOfd9i1Oa3HenOMKdUkCXmZRqcz/zT1+9++s17992br9/+8q6HrduPfFXC
ZJrVFVqXKFazycScemd0WYXqBVbmwz53BgfFLkkOBxql7neI/v3lv0qi6oue
YVd4gIFZ2mDRhwtFIhtW5nzk/47wjbdbSDf0FcFRZDUCnaBv+OYFCim5HI8R
HHxahBqm+QP+EWu05tpHXHjmwCKfBfTMYBbdYlsULaw4rF1WKZrtAEmA81wL
DNkQm4aRlGCFtZQRu/Q9XpJKTasVQNa10nSHYJduTeho7YMH9xk2Nwkn/ZTX
LgajiK3RIomIKbwb1NcCqRg8XRKZtZhsHKy4FqZOD+vsKCScdM5qCtePsRYh
J49TFoB8zIgGUXd3PdjXUUxOHXuLIFG+t3vuMoFQfs09TAiD/Ya4zn0Q08iv
EgU1kAyJ9pJpHmnvsZuMXjMvmyN3HlUruDcJ8A6KPTyNdhGVkBuSiHsIo59+
w9EyiPlWtnEpl8YC+u0JfomRtfW7J+fHXyBzFZU9L7WdmenhZwUBmOPyb/Bk
xcELNHoqO/LHBG+apKls+8FHWaKkNzu5FdbhyBeS39mqUx/rYaw0yBo+FkmW
d4E4f3714ze/fP99k4N9GHJlhiNOIG+sv/V6B0PeihC7zp2gqHm8TNWMV7O7
XV552rGW97mlocVsvBNPlDYuxWjcOTMrj81ZzG5G0hbEHNlc930eBMigggm+
BXu5YNL0JRnnpH0Gj2Ns3pxRZ+gNhHvyFgUM33zmas9EVgKt7Cy4sfnmReSO
wNOuKvXTJRIxluagmteSJev7RmSozQ2oppAd5wHxAXjwcXqVneWTb38fTcbj
sZtSlUJ5FSQkHI/mSXATMkcfSRZnw5lSzsoiQNXPXTYFddbZiqXGZOFVIui0
dbbIFqfE/JyCz7sBj92r35Rz0osmpjg+Bf/otGYfs1dr3AHtx9zVlqWtjaP2
RXQ74puPlTNdthGKexw2S83jKYRa11lCPkST/IsM9kHK3uHfG2UrGsbY5Pz5
xciAdd3vpcdk2eFlS2A7s1g/ZP6Cqb7+zw9vf3rn/fzbm6/efo8GFCta7G2q
xhDP5mEd2hl/tPMEDQhZmz888IHmGB0/+t9R2n/AIO7bhQdHmXYjDSQBv99A
0BA5Rp+9ROOsd8kF+MUDAOydvVlKPOI69ziDSfrdDiViDfphdcGoggkczD/M
NaTSLLYvlpjmFMWIAKmBjLrIzNLvkmikNMvoVJvhz5+Ps0qDYb/lqGxZvNdo
Zc6QK2KqEpHpcTr0bspSMl/xQDTJbqdK0RtVy5q71gnkdcvcgrusuDE85XMT
MgqmVWJTm7OfpwSccEcikAZySy91fjvU7BEckZhjL3a/zp0YoJ6kugoxoYo7
iwQFTNM0MHp+0ZWAg3+Zm26a2B6l7OLYJfESeNOkcYAj98LuNEQP1xLPO0ob
dbi+gE6w1Zz3mTYDa1rgnTx/OpmOOyy/wqAHOKFdvFs4INw2G+gRaLH73W3i
c5ca6FV3t9GdBC4uAi/b2D0A+wRrBuljfG2RjNfefpNO/0qiIaEh1DKVoUn9
i5Lq2zO2LwIC1KkpC7Vp8jGSmLDiVT8Mx3KUfomU+8LI1iKq4tZ0BPaRA7kR
FWSSvlfULwWy34oDq5pWXw8rk5xDLKrdF6IQuRcvDBdEKPzvtn0BrCVYeSrC
sfKF7r72DlZhwzTwFOb5P8G2+TmwSwAA
--1678434306-1903068619-1025178248=:4174--
