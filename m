Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbULCJNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbULCJNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbULCJNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:13:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:11159 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262121AbULCJMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:12:35 -0500
X-Authenticated: #4512188
Message-ID: <41B02DFD.9090503@gmx.de>
Date: Fri, 03 Dec 2004 10:12:29 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041202121938.12a9e5e0.akpm@osdl.org> <41AF94B8.8030202@gmx.de> <20041203070108.GA10492@suse.de>
In-Reply-To: <20041203070108.GA10492@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD85C1315DE481AF91C661D9B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD85C1315DE481AF91C661D9B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe schrieb:
> On Thu, Dec 02 2004, Prakash K. Cheemplavam wrote:
> 

>> 0  3   3080   2208   1156 817712    0    0  3592 75624 1326  2289  1 36  0 
>> 63
>> 0  3   3080   2664   1156 818240    0    0  5124 15692 1302   992  1 18  0 
>> 81
>> 0  3   3080   2580   1160 815832    0    0  4356 155792 1375  1064  1 39  
>> 0 60
>> 0  3   3080   2472   1160 817124    0    0  3076 100852 1345  1138  1 23  
>> 0 76
>> 2  4   3080   2836   1148 816228    0    0  3336 100412 1352  1379  1 47  
>> 0 52
>> 0  4   3080   2708   1144 815964    0    0  3844 48908 1343   871  1 25  0 
>> 74
>> 0  3   3080   2748   1152 815984    0    0  3332 71996 1338   843  1 27  0 
>> 72
> 
> 
> Can you try with the patch that is in the parent of this thread? The
> above doesn't look that bad, although read performance could be better
> of course. But try with the patch please, I'm sure it should help you
> quite a lot.
> 

It actually got worse: Though the read rate seems accepteble, it is not, as 
interactivity is dead while writing. I cannot start porgrammes, other programmes 
which want to do i/o pretty much hang. This is only while writing. While reading 
there is no such problem.

Prakash

  5   2692   5440   1640 917964    0    0  2332 72364 1337   782  1 28  0 71
  0  5   2692   5536   1540 917116    0    0  2116 85360 1346   785  2 27  0 71
  1  4   2692   7016   1496 919488    0    0  2152 71664 1329   740  3 29  0 68
  0  4   2692   5112   1476 922536    0    0   872 110592 1328   798  0 17  0 83
  0  4   2692   5560   1492 922144    0    0  1316 57348 1323  2162  1 21  0 78
  0  4   2692   5240   1500 921808    0    0  2088 92200 1352  1285  1 26  0 73
  0  4   2692   5816   1576 922064    0    0  1352 60716 1316   737  1  5  0 94
  0  5   2692   5484   1588 920004    0    0  2072 87732 1327  3522  2 50  0 48
  0  4   2692   5696   1660 920628    0    0   956 97284 1336   676  1 28  0 71
  0  4   2692   5368   1592 921808    0    0  1296 23208 1367  4870  2 35  0 63
  0  4   2692   5176   1628 922708    0    0  1576 67932 1400   721  0  4  0 96
  1  4   2692   5496   1684 922604    0    0  2372 53216 1320   684  1  6  0 93
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  1  4   2692   6432   1744 924664    0    0  3144 31484 1331   651  1  5  0 94
  0  4   2692   5496   1724 922056    0    0  2336 117040 1306  7770  1 63  0 36
  0  4   2692   5500   1724 921588    0    0  2576 28992 1314  1244  1 26  0 73
  0  5   2692   5484   1728 919340    0    0  1168 128796 1334 77435  2 45  0 53
  0  4   2692   5432   1756 920864    0    0  1488 100392 1325  1100  1 25  0 74
  1  4   2692   5368   1772 921900    0    0  1312 52180 1312  2087  1 21  0 78
  0  4   2692   5240   1716 922272    0    0  2076 56352 1305   939  1 13  0 86
  0  4   2692   5496   1732 921592    0    0  2596 68576 1320  1170  1 18  0 81
  0  4   2692   5368   1776 921364    0    0  1588 21904 1281  1201  1 23  0 76
  0  4   2692   5516   1852 921840    0    0  6560 93864 1593   967  1  8  0 91
  0  4   2692   5176   1816 922148    0    0  1068 73728 1581  4683  2 37  0 61
  0  4   2692   5484   1756 922408    0    0  2096 73632 1450  1456  2 20  0 78

--------------enigD85C1315DE481AF91C661D9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBsC4AxU2n/+9+t5gRAsdAAJ9fxl8zr3ygAG9zSelQfwaS3kOtYwCg8xYC
YuycgOBAw4Tl/1naBLvK1+A=
=m3Ih
-----END PGP SIGNATURE-----

--------------enigD85C1315DE481AF91C661D9B--
