Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130077AbRBGTQN>; Wed, 7 Feb 2001 14:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130157AbRBGTPx>; Wed, 7 Feb 2001 14:15:53 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:36875 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130077AbRBGTPo>; Wed, 7 Feb 2001 14:15:44 -0500
Message-ID: <3A819EA8.D4D8C570@baldauf.org>
Date: Wed, 07 Feb 2001 20:14:48 +0100
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <511820000.981567599@tiny>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

this is the output of my zero block detection utility. Note that in all the
files mentioned, zero bytes never can exist there, so every zero byte is a bug.
The output format is:

${filename} ${decompressed?"d":"n"} ${startIndex} ${endIndex} ${length}

The data (sorted):

_log.2001-01-16--00-04-57.broken.orig   n       2312    3858    1546
_log.2001-01-17--00-02-27.orig.broken   n       2088    2391    303
_log.2001-02-06--00-00-30.corrupted     n       9260    10116   856
log.2000-04-07--00-00-20.gz     d       41988   42231   243
log.2000-04-29--00-00-17.gz     d       91843   91924   81
log.2000-07-20--00-00-01.gz     d       14690   14780   90
log.2000-07-20--00-00-08.gz     d       26234   26314   80
log.2000-07-20--00-01-06.gz     d       8255    8430    175
log.2000-11-08--00-00-02        n       37232   37959   727
log.2000-11-08--00-00-10.gz     d       2008    3588    1580
log.2000-11-08--00-01-01.gz     d       27237   27681   444
log.2000-11-08--00-01-38.gz     d       15547   15721   174
log.2000-11-08--00-01-52.gz     d       8254    8342    88
log.2000-11-08--00-03-42.gz     d       10985   11522   537
log.2000-11-11--00-00-03        n       3152    3923    771
log.2000-11-11--00-00-03.gz     d       3152    3923    771
log.2000-11-12--00-40-18.gz     d       239     1167    928
log.2000-11-14--00-01-17.gz     d       2472    3273    801
log.2000-11-14--00-01-26.gz     d       3152    3874    722
log.2000-11-15--00-00-58.gz     d       2944    3112    168
log.2000-11-15--02-55-09.gz     d       203     3343    3140
log.2000-11-16--00-01-47.gz     d       854     2206    1352
log.2000-11-18--00-01-42.gz     d       1704    2941    1237
log.2000-11-20--00-03-28.gz     d       1098    1914    816
log.2000-11-21--00-00-35.gz     d       3208    3392    184
log.2000-11-22--00-15-01.gz     d       6320    6632    312
log.2000-11-23--00-00-57.gz     d       2784    3354    570
log.2000-11-23--00-02-14.gz     d       2896    3697    801
log.2000-11-24--00-03-46.gz     d       2784    3413    629
log.2000-11-25--00-01-25.gz     d       2560    3363    803
log.2000-11-26--00-09-39.gz     d       112     3513    3401
log.2000-11-27--00-56-50.gz     d       252     1660    1408
log.2000-11-28--00-01-34.gz     d       1458    2858    1400
log.2000-11-28--00-02-07.gz     d       757     3117    2360
log.2000-11-29--00-00-07.gz     d       1704    3404    1700
log.2000-11-29--00-02-20.gz     d       936     1384    448
log.2000-11-29--00-05-40.gz     d       2416    3577    1161
log.2000-12-02--00-06-03.gz     d       627     3419    2792
log.2000-12-02--00-12-42.gz     d       321     1417    1096
log.2000-12-05--00-00-47.gz     d       1536    3123    1587
log.2000-12-06--00-00-35.gz     d       1080    3492    2412
log.2000-12-08--00-07-01.gz     d       3592    3692    100
log.2000-12-09--00-11-02.gz     d       1224    3955    2731
log.2000-12-10--00-10-03.gz     d       1211    3691    2480
log.2000-12-12--00-04-25.gz     d       3200    3743    543
log.2000-12-13--00-00-42.gz     d       2408    3104    696
log.2000-12-13--00-01-31.gz     d       5270    6822    1552
log.2000-12-13--11-09-43.gz     d       3592    3757    165
log.2000-12-14--00-01-30.gz     d       1600    2500    900
log.2000-12-15--00-00-28.gz     d       2560    3423    863
log.2000-12-19--00-04-08.gz     d       442     2682    2240
log.2000-12-20--00-01-29.gz     d       2672    3199    527
log.2000-12-20--00-02-47.gz     d       4682    5378    696
log.2000-12-21--00-00-16.gz     d       4872    6683    1811
log.2000-12-21--00-01-23.gz     d       9210    10170   960
log.2000-12-21--00-08-48.gz     d       2544    3256    712
log.2000-12-22--00-01-42.gz     d       4466    6938    2472
log.2000-12-23--00-00-11.gz     d       4872    6774    1902
log.2000-12-23--00-03-01.gz     d       1352    3827    2475
log.2000-12-24--00-00-15.gz     d       2064    3597    1533
log.2000-12-25--00-01-07.gz     d       1004    2188    1184
log.2000-12-26--00-01-36.gz     d       2080    3508    1428
log.2000-12-27--00-01-13.gz     d       1128    2684    1556
log.2000-12-27--00-05-42.gz     d       4396    4836    440
log.2000-12-30--00-06-54.gz     d       1280    3613    2333
log.2001-01-01--00-05-32        n       2896    3534    638
log.2001-01-01--00-12-07        n       4204    5964    1760
log.2001-01-03--00-03-11.gz     d       1536    3104    1568
log.2001-01-03--00-04-22        n       2160    3243    1083
log.2001-01-04--00-23-53.gz     d       2408    3587    1179
log.2001-01-05--00-26-01.gz     d       3184    3422    238
log.2001-01-06--00-01-52.gz     d       1104    3543    2439
log.2001-01-09--00-00-07.gz     d       2814    3310    496
log.2001-01-09--00-01-45.gz     d       1960    3835    1875
log.2001-01-09--09-43-49        n       1392    3704    2312
log.2001-01-11--00-00-18.gz     d       2048    3511    1463
log.2001-01-11--00-01-24.gz     d       1110    2214    1104
log.2001-01-12--00-00-10.gz     d       800     3589    2789
log.2001-01-12--00-00-30.gz     d       1952    3717    1765
log.2001-01-12--00-05-35.gz     d       1904    3861    1957
log.2001-01-14--00-04-22.gz     d       68      2180    2112
log.2001-01-15--00-03-52.gz     d       1038    1534    496
log.2001-01-16--00-00-03.gz     d       992     1673    681
log.2001-01-16--00-04-36.gz     d       2592    2699    107
log.2001-01-17--00-02-27.gz     d       36301   36634   333
log.2001-01-17--00-04-13.gz     d       312     590     278
log.2001-01-18--00-19-34.gz     d       3040    3699    659
log.2001-01-21--00-00-18.gz     d       5152    5624    472
log.2001-01-23--00-01-21.gz     d       1624    3510    1886
log.2001-01-24--00-04-36.gz     d       272     2518    2246
log.2001-01-27--00-00-13.gz     d       6512    7044    532
log.2001-01-29--00-03-12.gz     d       1129    2857    1728
log.2001-01-29--00-20-36.gz     d       3528    3726    198
log.2001-01-31--00-00-23.gz     d       5984    6254    270
log.2001-02-01--00-14-07.gz     d       560     2208    1648
log.2001-02-02--00-00-25.gz     d       1878    2582    704
log.2001-02-02--00-02-49.gz     d       3160    3353    193
log.2001-02-02--00-06-18.gz     d       1320    1423    103
log.2001-02-06--00-01-10.gz     d       2192    3037    845

Note that the files are in about 20 different subdirectories, but the directory
names were stripped in the output. Please also note that some of the zeroing may
not come from the bug, but from crashes. (Maybe the problem which creates
zeroing on crashes and the bug are identical?) The machines configuration:

plato:~ # uptime
  8:03pm  up 70 days,  8:03,  5 users,  load average: 3.18, 2.50, 2.57
plato:~ # uname -a
Linux plato 2.4.0-test10 #4 Wed Nov 8 18:14:47 CET 2000 i586 unknown
plato:~ #

Because the uptime is 70 days, results from december 2000 on cannot be due to
crashes.

The .gz files are not created on the fly, they are created after the log file
for the next day is created and the former plain log file has no write accesses
anymore. So the corruption is from the original log file, not from the program
which writes the .gz file.

Xuân.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
