Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131306AbRACMQc>; Wed, 3 Jan 2001 07:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131545AbRACMQW>; Wed, 3 Jan 2001 07:16:22 -0500
Received: from www.wen-online.de ([212.223.88.39]:22547 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131306AbRACMQU>;
	Wed, 3 Jan 2001 07:16:20 -0500
Date: Wed, 3 Jan 2001 12:30:57 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <Pine.Linu.4.10.10101030814540.1271-100000@mikeg.weiden.de>
Message-ID: <Pine.Linu.4.10.10101031218370.1703-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Mike Galbraith wrote:

> Feel is _vastly_ improved.

Except while beating on it, I found a way to turn it into a brick.

If I run Christoph Rohland's swptst proggy, interactive disappears
to the point that login while it is running is impossible. ~15 minutes
later I got 'login timed out after 30 seconds'.  ~10 minutes after
that, the prompt came back.

	-Mike

on other vt..
./swptst 1 48000000 4 12 100

Script started on Wed Jan  3 11:16:46 2001
[root]:# schedctl -R vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0  17688 105040    396  15400  84 100   515  1117  315  1321   2  50  47
 0  0  0  17688 105040    396  15400   0   0     0     0  102    10   0  95   5
 0  0  0  17688 105040    396  15400   0   0     0     0  111     8   0  96   4
 0  0  0  17688 105040    396  15400   0   0     0     0  106    10   0  94   6
 0  0  0  17688 105028    396  15412  12   0     4     0  109    21   0  92   8
 0  4  2  85240   1748    184  11996 4024 81876  2014 20512 3122  8444   0  35  65
 0  5  3  99064   1432    188  25964 8856 5240  2472  1310 3645  5724   0   5  95
 0  5  2 102404   1436    188  29072 4476 9896  1172  2474  880  1594   0  14  86
 0  4  2 102404   1460    188  29032 5700   0  1425     0  440   656   1   9  91
 0  4  2 114452   1432    188  40996 3224 4392   806  1098  344   523   0  19  81
 1  3  3 114452   1432    188  40732 4080 11712  1020  2928  438  1061   0  26  74
 1  4  2 189568   1732    184 115060 75948 31108 19811  7777 4840  7186   0  18  82
 0  5  2 189568   1436    196 114560 5988 38224  1641  9556 1065   938   0  34  66
 0  5  2 192564   1432    196 116960 48712 6416 12235  1604 4913  6910   0   8  92
 0  4  1 192564   1432    196 116960 4136   0  1034     0  357   479   0   7  93
 1  3  2 192528   1432    196 116968 3284   8   834     2  371   510   0   5  95
 2  3  3 192512   1436    184 116972 17772 2452  4561   613  894  1110   0  13  87
 4  0  1  14964  24988    188  10068 548   0   787     0  162   137   0  75  25
 3  1  2  41356   1404    184   8180 108 35200   792  8800  818  5539   0  53  47
 4  2  2  75304   1432    184   9536 204 30896   215  7724  570  1705   0  56  44
 1  3  0  99440   1584    184  26304 8512 13972  2128  3493  622   858   0  28  72
 0  5  2 114228   1432    184  40880 16708 16464  4206  4116 2633  4967   0  11  89
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  4  3 115288   1432    184  41732 3600 11000   900  2750  370   832   1  32  67
 1  3  1 116576   1432    184  43020 3168   0   792     0  415   561   0   5  95
 1  4  2 117940   1580    180  44092 8256 2644  2089   661 1196  1659   0   6  94
 1  4  3 117912   1432    180  44236 1960   0   490     0  965  1216   0   9  91
 0  5  2 118076   1884    184  43908 1108 1588   283   397  590   747   0  15  85
 1  4  2 161668   2300    184  86164 155412 129228 40971 32307 9921 17331   0  23  77
 4  2  2  15368  57384    196  10448 46812 3396 13012   849 2707  3139   0  20  80
 0  7  2 134100   1460    180  60068 195944 223620 53567 55908 47036 84839   0  12  88
 4  1  1  19824  40776    188  14752 195852 199904 52674 49976 45992 77956   0  11  89
 0  5  2 142680   1656    184  68304 184740 184356 49300 46089 48109 82885   0   9  91
 6  3  0  19384   1404    184  13268 879100 1027052 246649 256793 204487 547788   0  22  78
 4  4  1  53712  50064    208  11264 484836 552776 137106 138209 125215 250077   0  18  82
 2  6  3 108684  15180    196  52812 398128 462772 111135 115729 53739 351528   1  53  46
 4  5  0  54808  45656    256  13984 12880 840  5412   242 1627  2070   3  97   0
 0  5  0  22620 104664    220  17392 18216 50944  6685 12746 2394 11021   1  44  56
 0  3  0  22528 103264    284  18476 692   0   666     0  254   390   5  18  77
 1  1  0  22160 102096    296  19564 536   0   840     0  242   438   7  15  78
 0  0  0  22120 102192    316  19932  60   0   320     8  171   333   3  50  48
 0  0  0  22120 102192    316  19932   0   0     0     0  101     7   0  96   4
 0  0  0  22120 102184    324  19932   0   0     7     0  108    33   0  84  16
 0  0  0  22120 102184    324  19932   0   0     0     0  101     7   0  96   4

[root]:# exit
exit

Script done on Wed Jan  3 12:00:31 2001

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
