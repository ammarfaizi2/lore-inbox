Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317820AbSGVVjm>; Mon, 22 Jul 2002 17:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317828AbSGVVjm>; Mon, 22 Jul 2002 17:39:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51653 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317820AbSGVVjl>;
	Mon, 22 Jul 2002 17:39:41 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF5933E2F2.D3E9CDE3-ON85256BFE.00744D4A@pok.ibm.com>
From: "Steve Pratt" <slpratt@us.ibm.com>
Date: Mon, 22 Jul 2002 16:42:19 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 07/22/2002 05:42:43 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on  2002-07-22 19:07:25 Christoph Hellwig wrote:

... snip

>> There
>> does not appear to be anything in either LVM2 or Device Mapper for
>> manipulating partition tables and resizing partitions.  User space tools
>> could be written to work with Device Mapper to make this happen, but
such
>> tools do not yet exist, AFAIK.

>And EVMS sucks in trucloads of fs code that already exists in userspace
>instead of using e.g. the parted library that can easily be linked to the
>LVM2 tools.

I don't know what code you are looking at because EVMS does
not suck in any code from existing fs utilities.  We only have enough
code to invoke the EXISTING utilities.  The only code we have is
simple things like version checks, superblock probes, and size
constraints.  For example, unlike  libparted which re-implements
resize of ext2 volumes, EVMS invokes the existing resize2fs.
In fact, all FSIMs have been developed in collaboration with the
filesystem owners, and in the case of JFS and EXT2/3 the FS
utility owners actually wrote the FSIM!

Also, if it is so easy to link parted with LVM2 to get greater
functionality,
why hasn't the LVM team or Andrew done this yet?  We went down this
road and found it was a dead end.

Steve




