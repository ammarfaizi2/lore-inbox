Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264847AbRFUGL0>; Thu, 21 Jun 2001 02:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbRFUGLQ>; Thu, 21 Jun 2001 02:11:16 -0400
Received: from zeus.kernel.org ([209.10.41.242]:43921 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264847AbRFUGLC>;
	Thu, 21 Jun 2001 02:11:02 -0400
Date: Thu, 21 Jun 2001 01:35:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
Cc: Alan Cox <laughing@shared-source.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac15
In-Reply-To: <20010619232328.A19241@frodo.uni-erlangen.de>
Message-ID: <Pine.LNX.4.21.0106210127150.14247-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Jun 2001, Walter Hofmann wrote:

> On Sun, 17 Jun 2001, Walter Hofmann wrote:
> 
> > I had already two crashes with ac15. The system was still ping-able, but
> > login over the network didn't work anymore.
> > 
> > The first crash happened after I started xosview and noticed that the
> > system almost used up the swap (for no apparent reason). The second
> > crash happened shortly after I started fsck on a crypto-loop device.
> > 
> > This does not happen with ac14, even under heavy load.
> > 
> > I noticed a second problem: Sometimes the system hangs completely for
> > approximately ten seconds, but continues just fine after that. I have
> > seen this with ac14 and ac15, but not with ac12.
> 
> FWIW, here is the vmstat output for the second (short) hang. Taken with
> ac14, vmstat 1 was started (long) before the hang and interrupted about
> five seconds after it. The machine has 128MB RAM and 256MB swap.
> 
> 
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  1  1  0  77332   1584  15632  67740  44   0   448     0  496   932  84  15   1
>  1  2  0  77456   1848  15944  66960   0   0   372   724  625  2296  62  20  18
>  3  0  1  77456   1780  16208  67044  72   0   336    80  584  1695  20  20  61
>  2  0  0  77404   1464  16672  66652   0   0   572     0  530  2649  26  19  55
>  3  1  0  77344   1464  17000  66480 124   0   656     0  419   879  12  16  72
>  0  3  0  77344   1468  17076  66388 184   0  1080     0  561   654   8   8  84
>  0  5  0  77892   1464  17184  66892 176 128   800   396  415  1050  14  11  74
>  0  5  0  77892   1600  17216  66868  16   0    68  1020  508   295   5   5  90
>  0  3  0  77892   1464  17316  66784  56   0   372    68  464  1287  22  14  64
>  2  3  0  77892   1464  17524  66828  76   0   440     0  398   987   8  12  79
>  1  3  0  77892   1464  17780  66680  32   0   512     0  367  1061  10  10  79
>  1  1  0  77880   1464  18020  66392 224   0   756     0  394  1579  43  12  44
>  2  1  0  77784   2172  18324  64820  16   0   992     0  529  1745  37  19  44
>  0  4  0  77936   1848  18428  65180 124   0   252   920  570   451  23   9  69
>  0  2  0  77888   1680  18564  65656  84   0   744     0  532   721  21  12  67
>  3  0  0  77876   1464  18700  65564   4   0  1176     0  487   804  26  16  58
>  0  3  1  77496   1468  18712  65700 424 100  1296   384  401   532  70  10  20
>  2  0  0  77920   1508  18804  65504  72 248   968   260  525   709  40   9  51
>  2  2  0  77908   1728  18788  65388   0 120  1000   568  568   608  41   8  51
>  0  4  0  77908   1620  18828  65548   0   0   172   356  545   420  22   8  69
>  1  1  0  77904   1712  18472  65464  36   0  1600     0  485   621  52  15  33
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  2  1  0  78124   1528  18496  64940 116  20   884   288  545   604  54  16  30
>  4  0  0  78124   1468  18548  64260   4   0   468     0  449   663  49   6  46
>  3  0  0  77844   3416  18492  63932 100   0   304     0  431  1915  80  16   4
>  1  2  0  77844   2892  18536  64204  60   0   284   820  583   917  64  13  23
>  1  0  0  77844   2824  18544  64236   0   0    40    68  591   550  36   6  58
>  3  0  0  77844   2604  18568  64372   0   0   120     0  455   474  64  13  23
>  1  0  0  77844   2472  18572  64440   0   0    56     0  399   617  35   9  56
>  1  0  0  77844   2456  18572  64460   0   0     0     0  515   721   8   6  87
>  0  0  0  77844   2448  18572  64468   0   0     4     0  469   655   8   8  83
>  1  0  0  77844   2384  18572  64528   0   0     0   428  538   641   7  10  83
>  0  0  0  77844   2388  18572  64528   0   0     0     0  492   733   3   9  89
>  0  0  0  77844   2368  18572  64548   0   0     0     0  520   804  11   7  82
>  0  0  0  77844   2336  18572  64580   0   0     0     0  473   680   6   6  89
>  1  0  0  77844   2276  18584  64608   0   0    12     0  490   966  30  13  56
>  2  0  0  77844   2228  18584  64648   0   0     0   344  539   589  47   7  47
>  3  0  0  77844   2228  18588  64692   0   0     4     0  381   455  29  11  60
>  2  0  1  77844   2180  18588  64700   0   0     0     0  453   781  33   9  58
>  1  0  0  77844   2160  18604  64708   0   0    16     0  390   852  18   5  77
>  2  0  1  77844   1940  18616  64912 124   0   212     0  318   756  40   8  52
>  3  0  0  77844   1680  18620  65180 240   0   244   576  492  1632  87  13   0
>  2  0  1  77844   1528  18540  65540 584   0   592     0  352  2466  90  10   0
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  2  0  0  77844   1800  18516  65588  40   0    40     0  357   675  89  11   0
>  3  5  2  77844   1464  18536  65916 1508  44  1660   264  435   852  37  16  47
>  1  0  0  77844   1484  18532  65968 864   0   936     0  386   667  89   7   5
>  1  0  1  77844   1464  18344  66220 1328   0  1416   280  416   519  54   5  41
>  1  0  0  78856   1464  18236  67776 4276 104  4276   228  528   743  25  12  63
>  2  0  1  78820   1540  18220  67748 588  24  1148    92  507  1816  72  11  16
>  1  0  1  78820   1500  18216  67664   0   0     4     0  319   327  92   8   0
>  1  0  0  78820   1484  18216  67684   0   0     0     0  391   308  94   6   0
>  0  0  0  78812   1468  18196  67716 636   0   996   488  578  1106  12  13  75
>  0  0  0  78808   1476  18196  67712   0   0     0     0  337   399  12  10  77
>  0  0  0  78808   1724  18196  67736  16   0    16     0  368   517   6   8  87
>  0  0  0  78808   1676  18220  67760   0   0    24     0  405   475   7   6  88
>  1  0  0  78752   1680  18232  67832 132   0   192     0  412   457  10  11  78
>  0  2  0  78752   1464  18244  67884  64   0    96   620  542  3293   8  27  66
>  5  0  0  77888   1464  18252  68060 896   0  1516     0  519   611  39  13  48
>  0  0  0  77000   2416  18276  67464 600   0  1516   280  592   764  19   8  73
>  2  0  0  77000   2556  18296  67500   4   0    28   268  595  1789  37  10  52
>  3  0  0  77000   1632  18320  67848 188   0   344   128  561   848  30  11  59
>  2  2  1  77000   1464  18404  67688   0   0   228   412  542  2434  42  18  39
>  1  0  0  77000   1464  18444  67324   8   0   152   224  386  1345  26  19  55
>  2  4  2  77084   1524  18396  66904   0 1876   108  2220 2464 66079   198   1
							   *************
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  1  0  77076   1608  18500  66452   0   0   456   200  493  1175  21  11  68
>  1  0  0  77108   1464  18512  66124   0   0   688     0  286   509  10   6  85

Ok, I suspect that GFP_BUFFER allocations are fucking up here (they can't
block on IO, so they loop insanely). 

Can you reproduce the problem with 2.4.6pre kernels ? 

