Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279544AbRJXMY1>; Wed, 24 Oct 2001 08:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279548AbRJXMYH>; Wed, 24 Oct 2001 08:24:07 -0400
Received: from home.geizhals.at ([213.229.14.34]:62726 "HELO home.geizhals.at")
	by vger.kernel.org with SMTP id <S279544AbRJXMX7>;
	Wed, 24 Oct 2001 08:23:59 -0400
Message-ID: <3BD6B278.3070300@geizhals.at>
Date: Wed, 24 Oct 2001 14:22:16 +0200
From: Marinos Yannikos <mjy@geizhals.at>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.5) Gecko/20011011
X-Accept-Language: de-AT,en,el
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gdth / SCSI read performance issues (2.2.19 and 2.4.10)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

our brand-new ICP GDT8523RZ controller with 6 disks peaks out at
45MB/s under 2.4.10, while with 2.2.19 it reaches 85MB/s (seq.
read performance). It should realistically be able to reach
at least 150-200MB/s in this configuration (RAID-5, 6 disks,
it's a 64-bit 66MHz PCI card). It's in a dual P3-1GHz box with
Tyan 2510NG board. Sequential write performance is OK with both
kernels, it's higher than the read performance on 2.4.10 (60MB/s).

Under 2.4.10, when I test the performance with a simple program
that just read()'s 16MB blocks from /dev/sda, both CPUs report
40-50% System time usage. 2.2.19 reports ~20% for one CPU (and
better performance).

Is there anything that can be done about this? It seems like a
serious performance problem either with the gdth driver or the
kernel and it renders this neat controller rather ineffective.

Regards,
-mjy
[please CC: answers]

