Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSGVS2U>; Mon, 22 Jul 2002 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSGVS2T>; Mon, 22 Jul 2002 14:28:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:15339 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317858AbSGVS2S>;
	Mon, 22 Jul 2002 14:28:18 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF493E1C65.D443AFFF-ON85256BFE.005D57E7@pok.ibm.com>
From: "Ben Rafanello" <benr@us.ibm.com>
Date: Mon, 22 Jul 2002 13:31:11 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 07/22/2002 02:31:18 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2002-07-21 at 1:24 Alan Cox wrote:
>On Sat, 2002-07-20 at 22:24, Andreas Dilger wrote:
>> I, for one, would like to have the choice to use the AIX LVM format, and
>> I'm sure that people thinking of migrating from HP/UX or whatever would
>> want to be able to add support for their on-disk LVM format.  It really
>> provides a framework to consolidate all of the partition/MD code into
>> a single place (e.g. RAID, LVM, LDM (windows NT), DOS, BSD, Sun, etc).
>
>The LVM format for AIX and so on call all be handled by LVM2

I believe you are referring to Device Mapper, which could, in theory,
handle the AIX metadata layout.  However, AFAIK, there are no tools
currently available or under development for Device Mapper to make
this happen.  Currently, EVMS is the only way to read/write to AIX
volumes under Linux.

>
>> EVMS also allows things like creating snapshots and resizing for
>> partitions that were not originally set up as LVM volumes (i.e. you can
>> "upgrade" your existing DOS partitions in-place to support LVM features
>> instead of requiring a backup/restore cycle.
>
>LVM2 has had this for months

EVMS can snapshot anything it sees - partitions, LVM volumes, MD devices,
OS/2 volumes, AIX volumes, etc.  LVM2 does do snapshots of LVM2 volumes,
but if it isn't an LVM volume, LVM2 can not snapshot it.  Device Mapper,
however, could snapshot partitions and other non-LVM volumes if only the
tools were available.  As for resizing partitions, EVMS has the code to
manipulate partition tables, including the resizing of partitions.  There
does not appear to be anything in either LVM2 or Device Mapper for
manipulating partition tables and resizing partitions.  User space tools
could be written to work with Device Mapper to make this happen, but such
tools do not yet exist, AFAIK.


Ben Rafanello
EVMS Team Lead
IBM Linux Technology Center
(512) 838-4762
benr@us.ibm.com


