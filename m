Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287513AbSBKHow>; Mon, 11 Feb 2002 02:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287516AbSBKHol>; Mon, 11 Feb 2002 02:44:41 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:18436
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S287513AbSBKHo2>; Mon, 11 Feb 2002 02:44:28 -0500
Date: Mon, 11 Feb 2002 02:45:38 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
cc: riel@surriel.com, <wli@holomorphy.com>
Subject: Results rmap12e + XFS + 2.4.19-pre9
Message-ID: <Pine.LNX.4.40.0202110232510.322-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These results may also show high preformance for non XFS filesystems. I
have not tested. Dont have the system capacity :-(

Simply amazing. There are no swapstorms, I do not see I/O slowing down
redrawing of windows. I do not see high swap in/outs in vmstat.

Using mozilla:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0  31556   1660      0  23372   0   0     0     0  178   169  73   8  19
 1  0  0  31556   1880      0  23372   0   0     0     0  128   106  25   7  68
 1  0  0  31556   1880      0  23372   0   0     0     0  167   212  27   2  71
 2  0  0  31556   1884      0  23376   0   0     4     0  143   178  63   3  35
 1  0  0  31556   1588      0  23384   0   0     0     0  129   188  41   4  55
 3  0  0  31556    724      0  23016  20   0    20     0  182   445  87  11   3
 1  0  0  31556   2172      0  23036  16   0    16     0  211   375  39   9  52
 1  0  0  31556   2144      0  23048  16   0    16     0  155   290  30   1  69
 1  0  0  31556   2148      0  23048   4   0     4     0  166   391  12   3  86
 2  0  0  31556   2024      0  23088  40   0    68     0  250   360  73   7  20

elvtune /dev/hda

/dev/hda elevator ID            0
        read_latency:           8192
        write_latency:          16384
        max_bomb_segments:      6

elvtune /dev/hdb

/dev/hdb elevator ID            1
        read_latency:           8192
        write_latency:          16384
        max_bomb_segments:      6


Memory:

             total       used       free     shared    buffers     cached
Mem:         61296      60508        788          0          0      21912
-/+ buffers/cache:      38596      22700
Swap:       182276      32452     149824


   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  1  0  30268    824      0  32020  20  58   142    60  228   259  25   6  70
 2  0  0  30296    648      0  31608   0  44   924    44  157   503  75  10  15
 2  0  0  30296    768      0  31160  20   0   744     0  173   311  32  17  51
 3  0  0  30296    904      0  29508   4   0   916     0  200   237  72  12  16
 1  1  0  30296    768      0  29184   0   0   748     0  158   278  76   7  17
 3  0  0  30308    640      0  29096  52  12   968    12  247   365  23   9  68
 3  0  0  30360    640      0  28220  64  72  1088    72  221   318  67  12  21
 1  1  0  30360    652      0  28256 340   0   624     0  214   393  34   7  60
 3  0  0  30360    680      0  28576  48   4   348     4  199   219  36  13  52
 4  0  0  30440    772      0  29072  48 100  1204   100  192   686  32  13  55
 4  0  1  31252    640      0  28748  76 924   752   924  218   359  67  12  21
 0  2  0  31444    640      0  28668   0 248   732   264  215   190  36  15  49
 4  0  1  31252    640      0  28748  76 924   752   924  218   359  67  12  21
 0  2  0  31444    640      0  28668   0 248   732   264  215   190  36  15  49
 2  0  0  31744    640      0  27728  12 448   416   448  224   206  84   9   8
 2  0  0  31744    676      0  27464   0   0   412     0  251   416  61   5  35
 3  0  0  31748    720      0  26992  12   4   540     4  205   354  82   9  10
 5  0  0  31776    676      0  26488 124  44   584    52  244   731  77   9  14
 3  1  0  32052    800      0  26240  48 320   676   348  185  1613  65  29   7
 2  0  0  32144    664      0  25956  32 152   504   160  175   711  66  13  21
 2  2  0  32616    788      0  26060   4 544   616   560  202   543  70   8  22
 0  2  0  33016    688      0  26088 152 464   292   472  240   376  15  10  75
 0  2  0  33016    696      0  26300 168   0   540     8  270   344  18   9  73
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0  33028    648      0  26260 220  36   532    36  267   202  14   8  78
 1  1  0  33092    980      0  25868 888 180   916   180  427  1165  17  10  73
 1  1  0  33092    904      0  25452 716   0   716     0  373   569   1   5  94
 2  0  0  33228    728      0  25004 500 104   804   104  280   380  27  17  56
 2  0  0  33836    644      0  24692   0 724   524   724  188   163  67  11  22
 2  0  0  34200    760      0  24536   4 372   632   372  226   199  78   7  15

After closing mozilla/evolution:

  procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0  36660   1220      0  25020  32   0   208     0  196   135  66  11  23
 1  0  0  36244   3444      0  25060  40   0   276     0  202   444  59  14  27
 1  0  0  36244   3200      0  25356   8   0   236     0  205   365  79  13   9
 3  0  0  35392   5160      0  25512 232   0   388     0  252  1048  48  13  39
 1  0  0  34900   7168      0  25260 216   0   336     0  264   474   8   3  89
 1  0  0  34900   6056      0  25260  40   0    40     0  220   322  63   6  31
 2  0  0  34900   7108      0  25280   8   0    28     0  188   281  14   4  82
 2  0  0  34892   6836      0  25680  52   0   288     8  219   892  71  12  17
 2  0  0  34884   6644      0  25952 116   0   388     0  237   368  55   5  40
 1  0  0  34884   6592      0  25952  52   0    52     0  183   270  96   4   0
 3  0  0  34840   6288      0  26096 164   0   260    40  253   344  34   8  59
 1  1  0  34228  13456      0  26296 144   0   620     0  227   293   5   9  87
 0  3  0  34228  12820      0  26768 212   0   580    12  218   226   3   4  93
 0  5  0  34208  11928      0  27276 156   0   612     8  208   240   7   7  87
 0  0  0  33960  11796      0  27816  88   0   604     8  256   349   8   7  86

Notice no swapouts and bo is little activity.

64MB Ram physical, 182MB swap total.

Nice work!

