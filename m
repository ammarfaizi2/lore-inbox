Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTGBSJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTGBSJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:09:18 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:42652 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264272AbTGBSJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:09:15 -0400
Date: Wed, 02 Jul 2003 11:12:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm3
Message-ID: <530600000.1057169520@flay>
In-Reply-To: <20030701221829.3e0edf3a.akpm@digeo.com>
References: <20030701203830.19ba9328.akpm@digeo.com><15570000.1057122469@[10.10.2.4]> <20030701221829.3e0edf3a.akpm@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> VFS: Cannot open root device "sda2" or unknown-block(0,0)
>> Please append a correct "root=" boot option
>> Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)
>> 
>> mm2 works fine.
>> 
>> Seems like no SCSI drivers at all got loaded ... same config file,
>> feral on ISP.
> 
> Works OK here.
> 
> The config option for the feral driver got gratuitously renamed.  To
> CONFIG_SCSI_FERAL_ISP.

Bah humbug.

Well, I tried that now. Still E_NO_WORKEE though. Does spit out one
error:

scsi HBA driver Qlogic ISP 10X0/2X00 didn't set a release method.
st: Version 20030622, fixed bufsize 32768, s/g segs 256
oprofile: using NMI interrupt.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 131072 buckets, 1024Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

Note the "scsi HBA driver Qlogic ISP 10X0/2X00 didn't set a release method"
bit.

