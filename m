Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289032AbSAZHdP>; Sat, 26 Jan 2002 02:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289036AbSAZHdH>; Sat, 26 Jan 2002 02:33:07 -0500
Received: from flrtn-4-m1-156.vnnyca.adelphia.net ([24.55.69.156]:23433 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S289032AbSAZHcx>;
	Sat, 26 Jan 2002 02:32:53 -0500
Message-ID: <3C525BA0.1050405@pobox.com>
Date: Fri, 25 Jan 2002 23:32:48 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: stock 2.4.18-pre6 vs low latency
Content-Type: multipart/mixed;
 boundary="------------030600040202050404030908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030600040202050404030908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is a followup to my earlier post about the
effect of the low latency patch on 2.4.18-pre6.

As it was pointed out, the stock kernel didn't
do badly. This is true, so I have conducted a
more stressful test to help highlight the effects
of the low latency patch.

In this test I ran a dbench sequence of 3 reps
each of dbench (1, 2, 4 ... 128), while doing
normal desktop activities e.g. pysol, reading
mail, running aim. The tested system also acts
as an iptables firewall for 3 internal hosts, but
the load is light.

As the results show, the histogram for the
low latency kernel is short and sweet. The
histogram for the stock kernel is rather more
involved. The low latency kernel also shows
no degredation in dbench results compared
to the stock kernel.

The histograms were generated as before:

1. start realfeel
2. run the dbench test
3. send sigint to realfeel to dump the histograms
4. generate the graphs with the included script
5. compare and contrast the results

The dbench results:

2.4.18-pre6 + lowlat
-----------------------
Throughput 106.33 MB/sec (NB=132.913 MB/sec  1063.3 MBit/sec)  1 procs
Throughput 108.236 MB/sec (NB=135.295 MB/sec  1082.36 MBit/sec)  1 procs
Throughput 108.818 MB/sec (NB=136.022 MB/sec  1088.18 MBit/sec)  1 procs

Throughput 107.13 MB/sec (NB=133.913 MB/sec  1071.3 MBit/sec)  2 procs
Throughput 107.611 MB/sec (NB=134.514 MB/sec  1076.11 MBit/sec)  2 procs
Throughput 106.817 MB/sec (NB=133.521 MB/sec  1068.17 MBit/sec)  2 procs

Throughput 107.051 MB/sec (NB=133.814 MB/sec  1070.51 MBit/sec)  4 procs
Throughput 106.648 MB/sec (NB=133.31 MB/sec  1066.48 MBit/sec)  4 procs
Throughput 103.107 MB/sec (NB=128.883 MB/sec  1031.07 MBit/sec)  4 procs

Throughput 105.72 MB/sec (NB=132.15 MB/sec  1057.2 MBit/sec)  8 procs
Throughput 106.87 MB/sec (NB=133.588 MB/sec  1068.7 MBit/sec)  8 procs
Throughput 106.091 MB/sec (NB=132.613 MB/sec  1060.91 MBit/sec)  8 procs

Throughput 105.146 MB/sec (NB=131.433 MB/sec  1051.46 MBit/sec)  16 procs
Throughput 105.636 MB/sec (NB=132.045 MB/sec  1056.36 MBit/sec)  16 procs
Throughput 106.289 MB/sec (NB=132.861 MB/sec  1062.89 MBit/sec)  16 procs

Throughput 47.5776 MB/sec (NB=59.472 MB/sec  475.776 MBit/sec)  32 procs
Throughput 47.1291 MB/sec (NB=58.9113 MB/sec  471.291 MBit/sec)  32 procs
Throughput 48.5488 MB/sec (NB=60.686 MB/sec  485.488 MBit/sec)  32 procs

Throughput 30.9873 MB/sec (NB=38.7341 MB/sec  309.873 MBit/sec)  64 procs
Throughput 30.2279 MB/sec (NB=37.7849 MB/sec  302.279 MBit/sec)  64 procs
Throughput 31.0719 MB/sec (NB=38.8399 MB/sec  310.719 MBit/sec)  64 procs

Throughput 18.1556 MB/sec (NB=22.6945 MB/sec  181.556 MBit/sec)  128 procs
Throughput 16.0057 MB/sec (NB=20.0071 MB/sec  160.057 MBit/sec)  128 procs
Throughput 17.7952 MB/sec (NB=22.244 MB/sec  177.952 MBit/sec)  128 procs


2.4.18-pre6 (no lowlat)
-----------------------
Throughput 108.359 MB/sec (NB=135.449 MB/sec  1083.59 MBit/sec)  1 procs
Throughput 107.866 MB/sec (NB=134.833 MB/sec  1078.66 MBit/sec)  1 procs
Throughput 108.862 MB/sec (NB=136.077 MB/sec  1088.62 MBit/sec)  1 procs

Throughput 107.715 MB/sec (NB=134.643 MB/sec  1077.15 MBit/sec)  2 procs
Throughput 98.9497 MB/sec (NB=123.687 MB/sec  989.497 MBit/sec)  2 procs
Throughput 102.91 MB/sec (NB=128.637 MB/sec  1029.1 MBit/sec)  2 procs

Throughput 72.1596 MB/sec (NB=90.1995 MB/sec  721.596 MBit/sec)  4 procs
Throughput 85.7308 MB/sec (NB=107.164 MB/sec  857.308 MBit/sec)  4 procs
Throughput 103.053 MB/sec (NB=128.816 MB/sec  1030.53 MBit/sec)  4 procs

Throughput 84.795 MB/sec (NB=105.994 MB/sec  847.95 MBit/sec)  8 procs
Throughput 88.9176 MB/sec (NB=111.147 MB/sec  889.176 MBit/sec)  8 procs
Throughput 104.329 MB/sec (NB=130.411 MB/sec  1043.29 MBit/sec)  8 procs

Throughput 68.186 MB/sec (NB=85.2324 MB/sec  681.86 MBit/sec)  16 procs
Throughput 47.0743 MB/sec (NB=58.8429 MB/sec  470.743 MBit/sec)  16 procs
Throughput 46.0652 MB/sec (NB=57.5814 MB/sec  460.652 MBit/sec)  16 procs

Throughput 50.2502 MB/sec (NB=62.8127 MB/sec  502.502 MBit/sec)  32 procs
Throughput 51.1178 MB/sec (NB=63.8973 MB/sec  511.178 MBit/sec)  32 procs
Throughput 49.8005 MB/sec (NB=62.2506 MB/sec  498.005 MBit/sec)  32 procs

Throughput 27.9207 MB/sec (NB=34.9009 MB/sec  279.207 MBit/sec)  64 procs
Throughput 30.3247 MB/sec (NB=37.9059 MB/sec  303.247 MBit/sec)  64 procs
Throughput 31.0434 MB/sec (NB=38.8042 MB/sec  310.434 MBit/sec)  64 procs

Throughput 19.0205 MB/sec (NB=23.7757 MB/sec  190.205 MBit/sec)  128 procs
Throughput 18.0334 MB/sec (NB=22.5418 MB/sec  180.334 MBit/sec)  128 procs
Throughput 18.2095 MB/sec (NB=22.7619 MB/sec  182.095 MBit/sec)  128 procs


The latency histograms:

2.4.18-pre6 + lowlat
-----------------------
0.0 8580075
0.1 13384
0.2 350
0.3 167
0.4 54
0.5 7
0.6 5
0.7 3
0.8 1
2.7 1
33.6 1

2.4.18-pre6 (no lowlat)
-----------------------
0.0 8224742
0.1 120095
0.2 54023
0.3 56931
0.4 10825
0.5 2017
0.6 823
0.7 560
0.8 480
0.9 386
1.0 319
1.1 313
1.2 214
1.3 190
1.4 142
1.5 107
1.6 74
1.7 46
1.8 41
1.9 31
2.0 25
2.1 15
2.2 17
2.3 12
2.4 12
2.5 12
2.6 12
2.7 12
2.8 10
2.9 9
3.0 3
3.1 5
3.2 1
3.3 2
3.4 2
3.5 1
3.6 2
3.7 2
3.8 2
3.9 1
4.0 2
4.1 1
4.2 1
4.3 2
4.5 1
4.6 2
4.7 2
4.8 2
4.9 3
5.0 1
5.1 1
5.2 1
5.4 1
5.5 1
5.6 1
5.8 1
5.9 2
6.0 2
6.2 1
6.5 1
6.7 1
7.0 1
7.7 1
7.8 1
7.9 1
8.7 1
8.9 1
9.5 1
9.7 1
9.9 1
10.1 1
11.2 1
11.4 1
12.0 1
12.6 1
12.7 2
13.4 1
13.9 1
14.2 1
14.4 1
15.8 1
16.9 1
17.0 1
17.3 1
17.5 1
19.1 1
19.3 1
20.8 1
21.9 1
23.6 1
24.3 1
24.8 1
25.1 1
26.1 1
26.9 1
27.0 1
28.8 1
30.2 1
31.7 1
32.7 1
33.5 1
33.7 1
34.7 1
36.8 1
36.9 1
41.8 1
42.2 1
43.7 1
44.8 1
45.1 1
45.2 1
45.6 1
45.9 1

The 2 small pngs are attached.

Best Regards,

Joe

--------------030600040202050404030908
Content-Type: image/png;
 name="pre6db.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pre6db.png"

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
rkJggg==
--------------030600040202050404030908
Content-Type: image/png;
 name="pre6lldb.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pre6lldb.png"

iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgAQAAAAAdquFJAAAAL3RFWHRTb2Z0d2FyZQBnbnVw
bG90IExpbnV4IHZlcnNpb24gMy43IHBhdGNobGV2ZWwgMV0EBjsAAATkSURBVHic7d1Nb+NU
FAbgrsiGafeItj8CifLhIRJ/oD8B2JeC0KjuTCB3UKWZXbNhh6qukJBG0JGCFCSr40UXWVSQ
BYKC3NqDsgiCtp5S2pvWsQ+2E1+nNKhNfAa55L1Sk1P75sn1R5y8cupOEHObAAgQYJ7AjvDJ
rYTFWfhT7JBHniCS1CInmu24ZA4HeuYZNXSKjPCxgQJlD6RhQTJPyNX9N5bdEHzyVvspbc9P
a3dI1gvTmi5+aDyY1L452r4+2BEH5K6++EvtPVqhTZtKVH1136oK6dn7Vk1854pN65Xyj0Ms
Mj2NRmg9WwxHuGm3S2Qs3bKkkFt2dLfnVjat2rNhwDO/5eodSx7GoLwXjtAPhyaNn6K7PVd+
Zc0dDgG2X/db9Yr/Zvso/GVGW/4kWoe7umhuudO7y2KvPmVrQ42w2/x/mS7ihTAHzRoJbMe3
HTE8OEIDCHBEsEKdj1lBnUoGLzhbmmMFH+y/9JjuTzC0Qhc8nbpbE6Z6DnG5CtSk9HDhDahk
FzykEi+4PttZ7nsTyw7G7SaBGVoWcCN8DzhuecKPPlXUN1hAz5MhGC2ysdFd8Czg12ua7snt
eV9rv0teCJ5kBIMF67Enq3MdW4aLHE74PSt40J4rSUP37bYXPzjzCN/3ZCkc4W2b7rWiB2dd
h8FaZ/mouT1/e/dDv7XSm5gJHDQxV+DA9lzBWWYw2GAG2Ud4AzYKQIAAAQIEyADGaZQTjNMo
KxilUU5wNUqjnzJ4QS+NLl1Moxlab4RLF9NodrByMY1mB+MGECBAgAABAgQIECBAgKODBe40
KrnTqMudRm3uNPqEO42WudOoQBoFCBAgQIAAAQIECBBgzsAGdxo1udOo4E6jkzg3mhmMG0CA
AAECBAgQ4P8CrHGDj8YPtLhByj3Y4Abzv5XZwTr/uVHBnUaneNPoDp3yplHjn383mqHJLsic
Rg3uNFrv1nwg5R7c4gbN3IMON7jCDVLuQbxJZQfH8GjjcINm7kGHGxzDo43DDZq5Bx1ucAx3
G/ZFltygl3vwITdIuQd3uEGDXN40aoSfv1jTqEEbvGm0Tovc50Zf4D43esibRnfI5U2jvctU
jRM4hh+J2Rc5/1sZuw1AgAABAgQIEOB/C+b/KkaS+5u633OnUeZzo/imLkCAAAECBAgQIECA
AMcAHMM0yn5N3XLur2JUQBoFCBAgQIAAAQIECBBgzkCHO42uc6dRJ/fX1LW506iNc6MAAQIE
CBAgQIAAAQJkBcXlKv235L6qvAHVcwTblP4fcBZQis++6E4YHfT7wVPx5dvh3R9ZwPN+8ETc
n2BoBQUei9/UCEdt5/GtWod/qXU4avP7wXYW6UKbuLoLwOuCs0nRUZWsJ5VbSKqKmvuyqmaK
vSJ4rajAwE1mp6+FlpFUDZFUS0m/4IBU5SQPtdIRBg01wuT5SFbVCKeS6lT121f9DtaT6meR
gunRJnk+ko8UqPb4VdVvVvVbeyepimYKfjAA/PwyWE76BWm/fVU55qB1mIJqHbq6AtU6VP36
16E5YCsHxaRqqq1cryRVIekXTKp+6VbWxE3asQECZAf941b8mguu6njtEXrdwwMXeHbXk42H
M9qdP3/lAc83PemWD6zqgsMIrt7yaotNRvDUt2oL/lVdrwl+e9SsT81o+kdbPOAQLf/g33iV
WXDddhTLAAAAAElFTkSuQmCC
--------------030600040202050404030908--

