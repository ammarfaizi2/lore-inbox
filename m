Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbTCFH1E>; Thu, 6 Mar 2003 02:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267880AbTCFH1E>; Thu, 6 Mar 2003 02:27:04 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:18828 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267879AbTCFH1B>; Thu, 6 Mar 2003 02:27:01 -0500
Message-ID: <20030306073727.2806.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: linux-kernel@vger.kernel.org
Cc: smatch-discuss@lists.sf.net
Date: Thu, 06 Mar 2003 02:37:27 -0500
Subject: smatch update / 2.5.64 / kbugs.org
X-Originating-Ip: 66.127.101.73
X-Originating-Server: ws3-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/*  
 * Smatch is an open source c error checker based 
 * on the papers about the Stanford Checker. 
 * (http://smatch.sf.net)  The documentation on coding 
 * smatch checks has been updated since my last email to 
 * this list. 
 *
 */

The smatch bugs for kernel 2.5.64 are up.  The 
new url for the smatch bug database is http://kbugs.org.  

One new script from Monday was "UnFree."  This check 
looks for variables that aren't freed on the error paths.
http://kbugs.org/cgi-bin/index.py?page=bug_list&script=UnFree&kernel=2.5.64

The bug database is still under heavy construction (ie it
is really bad).  But I hope to improve it some more this
week.  Also I plan to add some documentation etc.

The possible bug count for 2.5.64 was 1018.  Eventually 
this information will all be available in a stats page but 
for now I'll just post the raw SQL...

mysql> select kernelver, script, count(script) from bugs where kernelver = "2.5.64" group by script, kernelver;
+-----------+-------------------+---------------+
| kernelver | script            | count(script) |
+-----------+-------------------+---------------+
| 2.5.64    | Dereference       |           469 |
| 2.5.64    | GFP_DMA           |             7 |
| 2.5.64    | ReleaseRegion     |            14 |
| 2.5.64    | SpinlockUndefined |            44 |
| 2.5.64    | SpinSleepLazy     |             4 |
| 2.5.64    | UncheckedReturn   |           119 |
| 2.5.64    | UnFree            |           333 |
| 2.5.64    | UnreachedCode     |            28 |
+-----------+-------------------+---------------+
8 rows in set (0.07 sec)

regards,
dan carpenter


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Meet Singles
http://corp.mail.com/lavalife

