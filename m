Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTDWD6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 23:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263948AbTDWD6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 23:58:40 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:40118 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263946AbTDWD6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 23:58:38 -0400
Message-ID: <20030423041036.28763.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: kernel-janitor-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, smatch-discuss@lists.sf.net
Date: Tue, 22 Apr 2003 23:10:36 -0500
Subject: smatch/kbugs.org update 2.5.68
X-Originating-Ip: 66.127.101.73
X-Originating-Server: ws3-5.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just returned from vacation yesterday.  So the kbugs.org 
update is a bit late.

The notable thing this release is the update to the UnFree 
script.  Credit for that goes to Oleg Drokin.  Apparently I 
screwed the script up with one of my merges.

For the 2.5.67 results there was a bug in the ifcond.pm 
module and that is why the Dereference and UnFree bug count 
was higher than it should have been.  There are still problems 
remaining with ifcond.pm which may be causing false positives 
in the Dereference and UnFree checks.

mysql> select count(*), script, kernelver from bugs where 
kernelver = "2.5.67" or kernelver = "2.5.68" 
group by kernelver,script order by script,kernelver;
+----------+-------------------+-----------+
| count(*) | script            | kernelver |
+----------+-------------------+-----------+
|      411 | Dereference       | 2.5.67    |
|      326 | Dereference       | 2.5.68    |
|        2 | GFP_DMA           | 2.5.67    |
|        5 | GFP_DMA           | 2.5.68    |
|       49 | ReleaseRegion     | 2.5.67    |
|       50 | ReleaseRegion     | 2.5.68    |
|       44 | SpinlockUndefined | 2.5.67    |
|       44 | SpinlockUndefined | 2.5.68    |
|        6 | SpinSleepLazy     | 2.5.67    |
|        5 | SpinSleepLazy     | 2.5.68    |
|      122 | UncheckedReturn   | 2.5.67    |
|      112 | UncheckedReturn   | 2.5.68    |
|      874 | UnFree            | 2.5.67    |
|      132 | UnFree            | 2.5.68    |
|       29 | UnreachedCode     | 2.5.67    |
|       26 | UnreachedCode     | 2.5.68    |
+----------+-------------------+-----------+

There are a total of 700 possible bugs for 2.5.68.  In 
terms of moderation, 74 have been moderated as bugs and 
73 as false positives.

best regards,
dan carpenter


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

