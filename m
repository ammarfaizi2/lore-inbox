Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWIFIyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWIFIyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 04:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWIFIyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 04:54:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:15275 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750706AbWIFIyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 04:54:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BJBKnovPHT6waW+mfXnI5oI0ZK/o91Epr5i2Sqog8EBVOXfnzpXBCuKXxGbBfK1Ckomar95RcCgSqRFeVTTPlcBEwxUU/LtVFxwwjzRfRsyplju8AtDxKjr8ZPSOxzxm+OMD4/16m7QuQ1AMSlakimRb94r0PUHG/tkTwyyKIZs=
Message-ID: <9a8748490609060154ye8730b0n16e23524010a35e4@mail.gmail.com>
Date: Wed, 6 Sep 2006 10:54:34 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Wrong free space reported for XFS filesystem
Cc: "Nathan Scott" <nathans@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For your information;

I've been running a bunch of benchmarks on a 250GB XFS filesystem.
After the benchmarks had run for a few hours and almost filled up the
fs, I removed all the files and did a "df -h" with interresting
results :

/dev/mapper/Data1-test
                     250G  -64Z  251G 101% /mnt/test

"df -k"  reported this :

/dev/mapper/Data1-test
                     262144000 -73786976294838202960 262147504 101% /mnt/test

I then did an umount and remount of the filesystem and then things
look more sane :

"df -h" :
/dev/mapper/Data1-test
                      250G  126M  250G   1% /mnt/test

"df -k" :
/dev/mapper/Data1-test
                     262144000    128280 262015720   1% /mnt/test

The filesystem is mounted like this :

/dev/mapper/Data1-test on /mnt/test type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log1/test_log,usrquota)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
