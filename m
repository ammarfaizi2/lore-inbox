Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317045AbSEWXXO>; Thu, 23 May 2002 19:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317048AbSEWXXN>; Thu, 23 May 2002 19:23:13 -0400
Received: from 102-208-ADSL.red.retevision.es ([80.224.208.102]:39996 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S317045AbSEWXXL>;
	Thu, 23 May 2002 19:23:11 -0400
Message-ID: <3CED7A65.7010004@zaralinux.com>
Date: Fri, 24 May 2002 01:25:25 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: es-es, en-us
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cannot write a 90' cd
In-Reply-To: <3CED69EB.2060003@zaralinux.com> <20020524005754.I27005@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> 90 minute CD-Rs have a tighter leading track, and only some CD-R drives
> are able to cope with that. For example my Ricoh doesn't, failing some
> 54 minutes after start. There is nothing you can do about that.
> 

It could be that, but I suspect something strange, the cd reports itself to be 
about 80', then cdrecord is unable to write past this 80', after cdrecord 
fixates the cd and ejects it I can see that there is still a virgin zone of 
about 5 milimeters at the edge of the disk.

On the other hand I have been able to overburn some cd to gain about half a 
minute when needed, but these were 74 or 80 minutes media.

The most strange thing is the scsi error, "no error":

Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 05 7D 89 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 63 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x63 Qual 0x00 (end of user area encountered on this track) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.004s timeout 40s

-- 
Jorge Nerin
<comandante@zaralinux.com>

