Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbTCSVN4>; Wed, 19 Mar 2003 16:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263169AbTCSVNz>; Wed, 19 Mar 2003 16:13:55 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:2744 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S263167AbTCSVNy>; Wed, 19 Mar 2003 16:13:54 -0500
Message-ID: <20030319212438.11259.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: linux-kernel@vger.kernel.org
Cc: smatch-discuss@lists.sf.net
Date: Wed, 19 Mar 2003 16:24:37 -0500
Subject: smatch/kbugs.org 2.5.65
X-Originating-Ip: 67.112.215.16
X-Originating-Server: ws3-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5.63 smatch results are up on http://kbugs.org.

The website is still no good.  For example, it's not
obvious that you have to click on the line number to view
the source.  Searching is improved however.  And also it 
has stayed online for over a week now.  ;)

Since the stats page is still not up so here is the raw 
data.

mysql> select kernelver, script, count(script) from bugs 
where kernelver = "2.5.64" or kernelver = "2.5.65" group 
by script, kernelver;
+-----------+-------------------+---------------+
| kernelver | script            | count(script) |
+-----------+-------------------+---------------+
| 2.5.64    | Dereference       |           469 |
| 2.5.65    | Dereference       |           321 |
| 2.5.64    | GFP_DMA           |             7 |
| 2.5.65    | GFP_DMA           |             5 |
| 2.5.64    | ReleaseRegion     |            14 |
| 2.5.65    | ReleaseRegion     |            48 |
| 2.5.64    | SpinlockUndefined |            44 |
| 2.5.65    | SpinlockUndefined |            44 |
| 2.5.64    | SpinSleepLazy     |             4 |
| 2.5.65    | SpinSleepLazy     |             6 |
| 2.5.64    | UncheckedReturn   |           119 |
| 2.5.65    | UncheckedReturn   |           118 |
| 2.5.64    | UnFree            |           333 |
| 2.5.65    | UnFree            |           872 |
| 2.5.64    | UnreachedCode     |            28 |
| 2.5.65    | UnreachedCode     |            28 |
+-----------+-------------------+---------------+

mysql> select count(*) from bugs where kernelver = "2.5.65";
+----------+
| count(*) |
+----------+
|     1442 |
+----------+

The noteworthy thing this time, is the new UnFree script
from Oleg Drokin.  It fixes some of the false positives
from the old script, but it also looks for a lot of new
problems.

The dereference bug script has 148 fewer false positives.
The credit for that mostly goes to Oleg Drokin as well.

I'm not sure why the RegionRegion script has so many new
bugs...

Mathew Wilcox had some GFP_DMA fixes merged.  Oleg Drokin
and Alex Tomas had some Memleak fixes merged.  There 
are more Memleak, ReleaseRegion and UnreachedCode fixes 
still on the way to Linus.

Happy hacking,
dan carpenter

-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

