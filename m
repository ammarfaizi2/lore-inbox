Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279630AbRJXWxF>; Wed, 24 Oct 2001 18:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279633AbRJXWwz>; Wed, 24 Oct 2001 18:52:55 -0400
Received: from home.geizhals.at ([213.229.14.34]:55053 "HELO home.geizhals.at")
	by vger.kernel.org with SMTP id <S279630AbRJXWwp>;
	Wed, 24 Oct 2001 18:52:45 -0400
Message-ID: <3BD746D3.20700@geizhals.at>
Date: Thu, 25 Oct 2001 00:55:15 +0200
From: "Marinos J. Yannikos" <mjy@geizhals.at>
Organization: Geizhals Preisvergleich
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.5) Gecko/20011011
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gdth / SCSI read performance issues (2.2.19 and 2.4.10)
In-Reply-To: <3BD6B278.3070300@geizhals.at> <3BD6ECE6.8C9435C4@zip.com.au> <3BD729B6.6030902@geizhals.at> <3BD73280.7FC6526D@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> [...] you can't read files through the filesystem
> at greater than 17?  Which filesystem?


ext2 (on which I did a "tune2fs -j", but then I found out that the
kernel apparently doesn't support ext3). But, see below.


>    [...] It'd be interesting to test it on the same machine with

>    the vendor's drivers and win2k.


Indeed - can't do so, unfortunately. It could also be an issue
with the RAID-5 configuration (block size and arrangement of the
disks in the array could be less than optimal as suggested by
the ICP BIOS), so I'm in touch with the very helpful ICP support
people as well.


> 	dd if=large_file of=/dev/null bs=4096k


OK, that's quite odd - now I get a reasonable ~55 MB/s whatever I
try (dd, cp), so that must have been my mistake (or due to the
kernel profiling option?).

By the way, I'm having lock-ups with 2.4.13 that I can reproduce
(vi <file on reiserfs partition> ... :q ... "Segmentation fault"
... lock-up - console input still works, but apparently processes
don't get scheduled).

Regards,
  Marinos

-- 
Marinos Yannikos, CEO
Preisvergleich Internet Services AG
Franzensbrückenstraße 8/2/16, A-1020 Wien
Tel./Fax: (+431) 5811609-52/-55

