Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271892AbTHMVow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271928AbTHMVow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:44:52 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:34502 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S271892AbTHMVov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:44:51 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6: XFS spins up the disk very often
Date: Wed, 13 Aug 2003 23:44:49 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308132344.49297.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if there is a list for these XFS issues...

Since I started with 2.5 in my laptop, I noticed that the disk with XFS was 
spinning up continously. I checked with vmstats, and I saw I/O almost every 
60 seconds. They were mainly outputs, among 11 and 250 blocks each time.

I checked every process and redirected all syslogd to /dev/tty7 to be sure no 
processes were generating the I/O. I could find none.

So finally I repartitioned the disk and copied the whole system to a XFS 
partition and to an Ext3. Then I tested both, rebooting each time and 
changing the root fs.

With Ext3 there is no problem, the disk spins off very rapidly, but XFS kept 
doint I/O's.

So I checked it again in 2.4.21-ac4. Although there were more XFS I/O than 
with Ext3, they were not so frequent as in 2.6.

I also played echoing different values to /proc/sys/fs/xfs/ and 
/proc/sys/vm/pagebuf/ files without noticeable changes.

Is it a problem in 2.6 or the /proc parameters must be fine tuned?


-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/
