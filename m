Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbSK3BbO>; Fri, 29 Nov 2002 20:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbSK3BbO>; Fri, 29 Nov 2002 20:31:14 -0500
Received: from 174-121-ADSL.red.retevision.es ([80.224.121.174]:41155 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S267198AbSK3BbL>; Fri, 29 Nov 2002 20:31:11 -0500
Date: Sat, 30 Nov 2002 02:38:32 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021130013832.GF15682@jerry.marcet.dyndns.org>
References: <20021129115405.GD15682@jerry.marcet.dyndns.org> <Pine.LNX.4.44L.0211291429260.15981-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211291429260.15981-100000@imladris.surriel.com>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.4.20-ac1-marcet i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Rik van Riel <riel@conectiva.com.br> [021129 21:00]:

>> In recent 2.4.20 pre and rc kernels ( I tend to use the ac branch ), I
>> had notice my system, when using X mainly, got terribly slow after some
>> use.

>First, lets get one thing straight:  the problem is the slowness,
>not necessarily the swap usage.  It is very easy to jump to wrong
>conclusions, so lets keep focussed on that part of the problem
>which we know to be true before we all start hacking on parts of
>the system which aren't related to the slowness...

OK, you might be right on this point. But that different kernels show
such a big difference in its willingness to swap out things in memory is
something to think about...

>> I can provide you with dmesg, /proc/meminfo or whatever might be useful.

>How about some output (maybe 20 lines) of 'vmstat 1' during the
>time where your system is slow, together with a short description
>of how large the various processes (X, Mozilla ...) in your system
>are ?

root # vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu-=
---
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id=
 wa
 0  1 265048   5248  32248 119108    6   15    65    62  252   585 21  6 73=
  0
 1  6 266648   4480  32316 120300    0 4656  2152  4652 1348   821 13  8 79=
  0
 1  0 265052   4496  31036 120184    8  336  1668   340 1226   765 15  7 78=
  0
 0  1 265052   4496  31112 121564    4    0  3152     0 1198   894 18  8 74=
  0
 1  0 265052   4504  31076 123112    0    0  3024  8576 1229   857 17  7 76=
  0
 0  1 265052   4496  30020 127816   12    0  3300     0 1283   862 16  6 78=
  0
 2  0 265052   5244  29980 129796    0    0  3520     0 1212   991 17  9 74=
  0
 2  0 265052   4604  30044 130904    0    0  3036     0 1213   903 20  8 72=
  0
 0  9 266664   4704  30068 130836    4 6612   212  6608 1533   558  9  4 87=
  0
 0  1 265048   4668  30080 131120    8  272  1632   308 1246   837 20 11 69=
  0
 0  2 265048   4680  28808 130356    0    0  2308    48 1198   912 18  8 74=
  0
 1  2 265048   4680  27592 133108   12    0  1500     0 1142   753 16  5 79=
  0
 1  2 265048   4756  26776 135432    4    0  1436     0 1151   783 17  8 75=
  0
 0  2 265048   4820  26556 137208   12    0  1488     0 1150   773 18  5 77=
  0
 0  3 265048   4820  26508 137832    0    0   544   728 1256   654 16  5 79=
  0
 1  1 265048   4876  26328 141604    8    0  2980   268 1228   992 20 10 70=
  0
 1  0 265040   4472  25924 140324   92    0  3200     0 1167  1569 58 15 27=
  0
 2  0 265048   4372  25896 141292    8 4808    76  4812 1286  2517 85 15  0=
  0
 1  1 265048   4348  24516 147516   24    0   860     0 1074  2550 83 16  1=
  0
 1  0 265048   4408  22992 154120   28    0   668     0 1078  2455 83 15  2=
  0

root # cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  394547200 378638336 15908864        0 22396928 258523136
Swap: 542826496 271384576 271441920
MemTotal:       385300 kB
MemFree:         15536 kB
MemShared:           0 kB
Buffers:         21872 kB
Cached:         167848 kB
SwapCached:      84616 kB
Active:         175416 kB
Inact_dirty:    123512 kB
Inact_clean:      7728 kB
Inact_target:    61328 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       385300 kB
LowFree:         15536 kB
SwapTotal:      530104 kB
SwapFree:       265080 kB
Committed_AS:   365684 kB

And these are some of the apps running, basically those more
memory-hungry, at this point I mean:
UID        PID  PPID  C    SZ  RSS PSR STIME TTY          TIME CMD
root     15312 15309  2 52651 50960  0 Nov29 ?        00:19:42 /usr/X11R6/b=
in/X
jmarcet  15409 15332  0  1223    4   0 Nov29 ?        00:00:00 /bin/sh --lo=
gin /usr/kde/3.1/bin/startkde
jmarcet  15444     1  0 18564 1580   0 Nov29 ?        00:02:04 kdeinit: kde=
d           =20
jmarcet  15509 15436  0  2525  432   0 Nov29 ?        00:00:03 artsd
jmarcet  15553     1  0 19098 1060   0 Nov29 ?        00:00:00 kdeinit: kno=
tify        =20
jmarcet  15556     1  0 17672  832   0 Nov29 ?        00:00:00 kdeinit: ksm=
server      =20
jmarcet  15560 15436  0 17966 2684   0 Nov29 ?        00:00:08 kdeinit: kwin
jmarcet  15571     1  0 19961 2568   0 Nov29 ?        00:00:24 kdeinit: kde=
sktop       =20
jmarcet  15591     1  0 19177 5488   0 Nov29 ?        00:00:32 kdeinit: kic=
ker         =20
jmarcet  15597 15436  0  5557   28   0 Nov29 ?        00:00:00 kdeinit: kio=
_file
jmarcet  15600 15571  0  3942 1672   0 Nov29 ?        00:03:15 /home/jmarce=
t/.kde/Autostart/gkrellm2
jmarcet  15637 15436  0 18397 2640   0 Nov29 ?        00:02:46 kdeinit: kon=
sole
jmarcet  15659 15436  0 18191 3776   0 Nov29 ?        00:00:21 kdeinit: kon=
sole
jmarcet  15682 15659  0  3598 6284   0 Nov29 pty/s1   00:00:17 /usr/bin/mutt
jmarcet  21557 15436  1 29878 23424  0 Nov29 ?        00:07:55 kdeinit: kon=
queror --silent
jmarcet  22528     1  0 17825  524   0 Nov29 ?        00:00:00 kdeinit: kio=
_uiserver   =20
jmarcet  17165 15591  7 18864 5552   0 Nov29 ?        00:36:20 appletproxy
jmarcet  10990 21557  1 20661 1880   0 Nov29 ?        00:05:31 /usr/kde/3.1=
/bin/nspluginviewer
jmarcet  12338 15436  0 18646 5656   0 01:19 ?        00:00:28 kdeinit: kon=
sole        =20

This is after the system has been in use with a 512MB swap partition for
around 1 hour. I must say it is barely usable as a desktop, way _far_
=66rom a responsive environment. looking at the memory numbers it's easy
to think I need more memory, but with other kernels, at the same load
-by load I mean of memory, not processor- or even much higher, swap
usage was maybe around 16MB, while there was still ~192MB if free cached
memory.
So yes, you are right that swap usage is not the problem. It seems more
like memory getting too dirty.
BTW, I was compiling something with make -j2, not very big, it was
htdig.
I must reinforce that switching virtual desktops was so slow that you
could see windows repainting slowly on the screen.

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) XP 1800+
stepping	: 2
cpu MHz		: 1544.999
cache size	: 256 KB

The system has both an IDE ATA-100 45GB an a SCSI U2W IBM 9GB drives,
swap partition is at the start of the IDE disk, since it is much faster,
throughput-wise, than the SCSI model.


--=20
Javier Marcet <jmarcet@pobox.com>

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3oFpgACgkQx/ptJkB7fry2tgCeM6mccQji+9wehp7YPGedJE0F
CSwAniU2VvNalhJmhmwaJH2XY4LUaYvM
=6QNR
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
