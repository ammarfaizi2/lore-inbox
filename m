Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTL3Bog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTL3Bog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:44:36 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:51442 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264303AbTL3Bod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:44:33 -0500
Date: Mon, 29 Dec 2003 17:44:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.4] Is a negative rsect in /proc/partitions normal?
Message-ID: <20031230014429.GL1882@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.23-rc5, and I've been running bonnie, burnMMX and burnK7 for
the last few days on my 3 drive md raid5 array, and I noticed that my
rsects[1] have gone negative.  I might consider this normal but /proc/stat
(which only shows hda) doesn't show any negative numbers for the same
stats[2]

Is this a bug?

[1]
major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq

   9     0  319388032 md0 0 0 0 0 0 0 0 0 0 0 0
   9     1      96256 md1 0 0 0 0 0 0 0 0 0 0 0
  56     0  160086528 hdi 240438349 1318355451 -414508366 16504630 101146331 1132637971 1281537580 24939164 -3 18108868 28693926
  56     1      96358 hdi1 58 28 178 1500 102 41 292 1710 0 3170 3210
  56     2     289170 hdi2 0 0 0 0 0 0 0 0 0 0 0
  56     3  159694132 hdi3 240438290 1318355420 -414508552 16503120 101146229 1132637930 1281537288 24937454 0 19884967 309062
  33     0  160086528 hde 240516418 1321486397 -388859454 40325686 90645794 1146603482 1312002136 18444936 -3 14785505 12315041
  33     1     289138 hde1 0 0 0 0 0 0 0 0 0 0 0
  33     2  159790522 hde2 240516417 1321486394 -388859462 40325686 90645794 1146603482 1312002136 18444936 0 24147141 26883069
   3     0  160086528 hda 240675036 1318323453 -412885008 27008859 110939441 1126008079 1306648420 28401642 -3 24294848 41908774
   3     1      96358 hda1 44 53 200 610 102 41 292 1470 0 2010 2080
   3     2     289170 hda2 207445 623814 6650072 2773650 7261 19429 224992 63170 0 1882590 2837130
   3     3  159694132 hda3 240467546 1317699583 -419535288 24234589 110932078 1125988609 1306423136 28337002 0 4327510 10687939

[2]
cpu  73561013 1160924 31161337 40771206
cpu0 73561013 1160924 31161337 40771206
page 1152185038 1257557610
swap 834055 28177
intr 1291475450 146654480 8 0 0 4 0 1 0 4 0 0 0 0 0 351908342 0 341855446 0 331412420 0 0 0 0 119644745 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
disk_io: (3,0):(352031779,240762616,3890919112,111269163,1325101012) 
ctxt 2665965022
btime 1071282031
processes 889037
