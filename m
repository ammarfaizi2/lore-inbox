Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVFNWTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVFNWTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVFNWTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:19:42 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:58127 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261381AbVFNWTX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:19:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ai0bs2h6/cPBf2vkncsUjog0tedaROSjrvzk/iIbBmxs3xwsFzgLWN+SOSAug3pv4SPfdnvEVfo3K6dNf8qzhC4C8kPBPw6d1NnG9LvbDf3US5Lq2lHeJgDxNJuIQIBQkznlTHJ77mGwBW9ePv31nmxI7avuai0sqDp8N/Mj/uw=
Message-ID: <b0fbeec4050614151973f0eec7@mail.gmail.com>
Date: Wed, 15 Jun 2005 10:19:23 +1200
From: John Duthie <beyondgeek@gmail.com>
Reply-To: John Duthie <beyondgeek@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SATA - SCSI Partition limit
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
     Need to simulate CDs shares on a linux/samba File server... has a
120 GB SATA drive in there ...

( linux-2.6.10 ) 

long story ...
      Shares had the wrong size for the evil VB program 
     (Tried mounting *.iso via loopbak - it didn't like it )
     Windows boxes that work just have lots of 700 mb partitions  ( 4
x extended with 6 or 7 logical in each )
     SO i thought "I know I'll just make lots of partitions"  oops ,
SCSI sub system only allows 15 Drives
  So now I could "Boot 2.6.11ac7 on it and specify the boot option
"all-generic-ide" " which worked wonders last time i had a problem
(Thanks Alan) because ide will allow more than 15 partitions.
  But the machine is now about 500 km away from me and changing a
linux system to boot from scsi to ide over ssh is not my idea of fun,
1 typo and I've got a long drive ahead :-(,
  are there any hard reasions for the 15 partition limit on scsi (
other than lots of dev files )

  how much work would a patch to halve the number of /dev/sd? files
and double the /dev/sd?[12]? files ( same number of devices
minor/major ) ?

I'm sure this will be a problem more people have as the SATA drives
get bigger.......

TIA
