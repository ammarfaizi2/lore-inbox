Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUD0SJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUD0SJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUD0SDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:03:23 -0400
Received: from bay8-f71.bay8.hotmail.com ([64.4.27.71]:51982 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S264251AbUD0SAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:00:18 -0400
X-Originating-IP: [217.94.156.150]
X-Originating-Email: [v_atanaskovik@hotmail.com]
From: "Vladimir Atanaskovik" <v_atanaskovik@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Some comments on "Unable to read UDF fs on a DVD"
Date: Tue, 27 Apr 2004 18:00:17 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY8-F71HeCye8WSv6D000283be@hotmail.com>
X-OriginalArrivalTime: 27 Apr 2004 18:00:17.0276 (UTC) FILETIME=[7F622BC0:01C42C81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I would like to give your some additional information regarding
the dicussion with the subject "Unable to read UDF fs on a DVD",
which can be found on:
http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=1&s=UDF&q=b

I am facing the same problem. I have SuSE 9.1 installed with the 2.6.4-52 
Kernel.

I also have CD-RW/DVD-RW/DVD+RW created with Roxio's DirectCD under
Windows XP.

The problems when mounteing the DVD/CD media as UDF are described in
all teh details in the discussion. So I will not repeat, since I face the 
same.

However, under SuSE 9.1 submount is used by default to handle removanle 
media.

So if you mount the CD/DVD via subfs, e.g

mount -t subfs /dev/hdd /mnt/dvd -o fs=cdfss,ro
then there is a difference compared to
mount  /dev/hdd -t  udf -o ro /mnt/dvd

When mounted via subfs (or as ISO 9660 FS) a ls /mnt/dvd displays
.
..
autorun.inf
udfrchk.exe
udfrinst.zl

The files can be accessed without any problems (e.g. autorun.inf can
be opened by vi)

The files listed above are created by DirectCD by default and are Windows 
Driver
for the UDF FS and are usually not accessible/visible.

The data created by the user (own files, directories), when media mounted as 
ISO9660 FS is NOT displayed.

Direct CD uses UDF 1.5 as FS.

Regards,
Vlad

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE* 
http://join.msn.com/?page=features/junkmail

