Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287684AbSAXMgQ>; Thu, 24 Jan 2002 07:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287697AbSAXMgG>; Thu, 24 Jan 2002 07:36:06 -0500
Received: from moutng1.kundenserver.de ([212.227.126.171]:61655 "EHLO
	moutng1.schlund.de") by vger.kernel.org with ESMTP
	id <S287684AbSAXMfy>; Thu, 24 Jan 2002 07:35:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 13:35:48 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201241046130.6560-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201241046130.6560-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020124123548.91B4F65F@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24. January 2002 10:47, Daniel Nofftz wrote:
> On 23 Jan 2002, Ed Sweetman wrote:
> > 1-2 degrees is within the sensor's deviation.   Either you dont have it
> > working correctly or it doesn't work at all in your case.
> >
> > You also need acpi idle calls, not just apm.   now this is just my guess
> > but apm idle calls might either mess things up or be disabled if acpi
> > idle calls are used and disconnecting the cpu... either way  you can't
> > have this patch work and apm work at the same time.
>
> or the vlc makes enough load on the mashine that there is no realy power
> saving ...

No, vlc creates between 15% and 25% load, when using XVideo output without
scaling: (source are plain unencrypted vob files on the server).

 1  0  1      0  51688     16 620376   0   0     0     0 1232  1068  25   1  74
 2  0  0      0  50792     16 621272   0   0     0     0 1091   985  22   2  76
 0  0  0      0  49772     16 622296   0   0     0     0 1246  1124  21   2  77
 0  0  0      0  48620     16 623448   0   0     0     0 1346  1129  24   2  74
 3  0  0      0  47720     16 624344   0   0     0     0 1086   960  14   5  81
 1  0  0      0  46696     16 625368   0   0     0     0 1227  1096  23   3  74
 0  0  0      0  45932     16 626136   0   0     0     0  970   913  19   1  80
 0  0  0      0  44908     16 627160   0   0     0     0 1242  1061  21   1  78
 2  0  0      0  43756     16 628312   0   0     0     0 1339  1052  18   5  77
 1  0  0      0  42852     16 629208   0   0     0     0 1108  1006  18   0  82
 0  0  0      0  41828     16 630232   0   0     0     0 1229  1112  17   0  83
 3  0  0      0  40676     16 631384   0   0     0     0 1358  1111  18   4  78
 0  0  0      0  39524     16 632536   0   0     0     0 1359  1114  17   3  80
 0  0  0      0  38628     16 633432   0   0     0     0 1170  1070  14   1  85
 4  0  0      0  37600     16 634456   0   0     0     0 1217  1005  18   1  81
 0  0  0      0  36836     16 635224   0   0     0     0 1003   997  18   1  81
 1  0  0      0  35812     16 636248   0   0     0     0 1241  1035  17   3  80
 1  0  1      0  34788     16 637272   0   0     0     0 1232  1020  15   2  83
 2  0  1      0  33888     16 638168   0   0     0     0 1092   963  16   2  82
 3  0  0      0  32872     16 639192   0   0     0     0 1239  1097  20   2  78
 0  0  0      0  31840     16 640216   0   0     0     0 1249  1136  13   4  83
 4  0  0      0  30688     16 641368   0   0     0     0 1329  1043  17   4  79
 0  0  0      0  29664     16 642392   0   0     0     0 2273  2045  18   9  73
 0  0  0      0  28640     16 643416   0   0     0     0 1218  1045  16   2  82
 2  0  0      0  27904     16 644184   0   0     0     0 1085  1400  22   1  77
 1  0  0      0  27256     16 644824   0   0     0     0 1106  1386  24   3  73
 0  0  0      0  26360     16 645720   0   0     0     0 1320  1391  24   2  74

Fullscreen mode (scaling) takes approx. 5% more.

 1  0  0      0   4440     16 668124   0   0     0     0 1494  2580  26   2  72
 1  0  0      0   4372     16 668252   0   0     0     0 1307  1465  27   2  71
 1  0  0      0   4364     16 668252   0   0     0     0 1284  2991  38   1  61
 0  0  0      0   4404     16 668252   0   0     0     0 1114  1482  30   2  68
 2  0  0      0   4416     16 668252   0   0     0     0 1111  1031  24   1  75
 1  0  0      0   4432     16 668252   0   0     0     0 1210  1076  21   2  77
 0  0  0      0   4444     16 668252   0   0     0     0 1260  1195  20   3  77
 2  0  0      0   4448     16 668252   0   0     0     0 1240  1101  27   1  72
 0  0  0      0   4456     16 668252   0   0     0     0 1367  1171  26   1  73
 0  0  0      0   4448     16 668252   0   0     0     0 1388  1182  24   2  74
 3  0  0      0   4448     16 668252   0   0     0     0 1236  1065  24   2  75
 0  0  0      0   4444     16 668252   0   0     0     0 1372  1199  26   1  73
 0  0  0      0   4444     16 668252   0   0     0     0 1373  1194  27   0  73
 3  0  0      0   4444     16 668252   0   0     0     0 1364  1101  24   2  75
 0  0  0      0   4444     16 668252   0   0     0     0 1246  1103  26   2  72
 0  0  0      0   4448     16 668252   0   0     0     0 1348  1077  24   2  74
 2  0  0      0   4448     16 668252   0   0     0     0 1374  1239  25   3  73
 0  0  0      0   4400     16 668252   0   0     0     0 1881  1697  25   4  71
 0  0  0      0   4412     16 668252   0   0     0     0 1113  1004  26   0  74
 2  0  0      0   4444     16 667996   0   0     0     0 1388  2767  38   3  59
 1  0  0      0   4392     16 668124   0   0     0     0 1425  1418  27   3  70
 0  0  0      0   4476     16 668252   0   0     0     0 1603  1725  25   4  71
 1  0  0      0   4376     16 668380   0   0     0     0 1491  1427  27   3  70

You can see, enough idleness...

The question is, why amd_disconnect=true causes this distortion. I tend to
believe that dis-/reconnecting CPU takes simply too long in this scenario.

> daniel
>
>
> # Daniel Nofftz
> # Sysadmin CIP-Pool Informatik
> # University of Trier(Germany), Room V 103
> # Mail: daniel@nofftz.de

Cheers,
  Hans-Peter
