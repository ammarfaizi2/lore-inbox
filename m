Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSF3Mvq>; Sun, 30 Jun 2002 08:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSF3Mvp>; Sun, 30 Jun 2002 08:51:45 -0400
Received: from sto-vo-kor.koschikode.com ([213.61.61.142]:12819 "EHLO
	sto-vo-kor.koschikode.com") by vger.kernel.org with ESMTP
	id <S315162AbSF3Mvp>; Sun, 30 Jun 2002 08:51:45 -0400
Message-ID: <3D1EFF5C.6010405@koschikode.com>
Date: Sun, 30 Jun 2002 14:53:48 +0200
From: Juri Haberland <juri@koschikode.com>
Organization: totally unorganized
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't boot from /dev/md0 (RAID-1)
References: <20020630124445.6E95B11979@a.mx.spoiled.org> <200206301449.51190.roy@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
>> Hi,
>> I had this once and resolved it with adding a "default" line to the
>> lilo.conf:
>> default = LinuxRaid
>>
>> Also have boot=/dev/md0, not boot=/dev/hda.
> 
> hm
> 
> I keep getting this one..
> 
> [root@jumbo root]# lilo
> boot = /dev/hda, map = /boot/map.0301
> Added linux2419rc1 *
> Added linux2418
> Added linux-orig
> Fatal: Duplicate geometry definition for /dev/md0
> 
> Any ideas?

Hm, I'm no lilo nor raid expert, but I'd suggest to strip down the
lilo.conf to the defaults. E.g. I have:
prompt
timeout=50
default=linux
boot=/dev/md2
map=/boot/map
install=/boot/boot.b
message=/boot/message

image=/boot/vmlinuz
        label=linux
        read-only
        root=/dev/md0



