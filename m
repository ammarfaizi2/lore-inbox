Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288882AbSAERQn>; Sat, 5 Jan 2002 12:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288881AbSAERQd>; Sat, 5 Jan 2002 12:16:33 -0500
Received: from hera.cwi.nl ([192.16.191.8]:26856 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288882AbSAERQY>;
	Sat, 5 Jan 2002 12:16:24 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 5 Jan 2002 17:16:22 GMT
Message-Id: <UTC200201051716.RAA234622.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, bryce@obviously.com, util-linux@math.uio.no
Subject: Re: Why would a valid DVD show zero files on Linux?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From bryce@obviously.com Sat Jan  5 17:14:28 2002

	Here is the table of contents mounted three ways.  First udf, then
	iso9660, then iso9660 nojoliet.  Only the udf version works with the
	application.  Note that the huge udf filesizes are not a mistake -
	this DVD is also offered as 7 CD set.

[iso9660 nojoliet:]

	/mnt/cdrom1/data:
	total 22849
	dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
	dr-xr-xr-x    1 root     root         2048 Feb 28  2001 ..
	-r-xr-xr-x    1 root     root      1181228 Feb 28  2001 gridak.dat
	-r-xr-xr-x    1 root     root      1921298 Feb 28  2001 gridak.ind
	-r-xr-xr-x    1 root     root      3603453 Feb 28  2001 grid.dat
	-r-xr-xr-x    1 root     root       797273 Feb 28  2001 grid.ind
	-r-xr-xr-x    1 root     root        34839 Feb 28  2001 vec.cov
	-r-xr-xr-x    1 root     root     15153107 Feb 28  2001 vec.v
	-r-xr-xr-x    1 root     root       643405 Feb 28  2001 vec.vi

Hmm. I find

total 3266826
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 .
dr-xr-xr-x    1 root     root         2048 Feb 28  2001 ..
-r-xr-xr-x    1 root     root     1832319997 Feb 28  2001 grid.dat
-r-xr-xr-x    1 root     root     51128921 Feb 28  2001 grid.ind
-r-xr-xr-x    1 root     root     34735660 Feb 28  2001 gridak.dat
-r-xr-xr-x    1 root     root      1921298 Feb 28  2001 gridak.ind
-r-xr-xr-x    1 root     root        34839 Feb 28  2001 vec.cov
-r-xr-xr-x    1 root     root     1424439251 Feb 28  2001 vec.v
-r-xr-xr-x    1 root     root       643405 Feb 28  2001 vec.vi

Could it be that you are using some old kernel, say, older than
2.4.13, that enables the "cruft" option when it sees a big file?
(You should see the corresponding messages in the logs.)

Andries
