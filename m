Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUCUSlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbUCUSlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:41:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:44011 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263687AbUCUSlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:41:45 -0500
X-Authenticated: #21910825
Message-ID: <405DE18B.7090505@gmx.net>
Date: Sun, 21 Mar 2004 19:40:11 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Device mapper devel list <dm-devel@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <405DD9E2.4030308@pobox.com>
In-Reply-To: <405DD9E2.4030308@pobox.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Kevin P. Fleming wrote:
> 
>> Jeff Garzik wrote:
>>
>>> So go ahead, and I'll lend you as much help as I can.  I have the
>>> full Promise RAID docs, and it seems like another guy on the lists
>>> has full Silicon Image "medley" RAID docs...
>>
>>
>> If these "soft" RAID implementations only support RAID-0/1/0+1/1+0, is

Not all of them. Some are RAID-5.


>> there really any need for a new DM target? Wouldn't you just need a
>> userspace tool to recognize the array and do the "dmsetup" operations
>> to make it usable?
> 
> 
> Ideally yes.  I don't see an in-tree RAID1 dm target though....

IIRC, even a RAID-5 dm target is on its way to mainline and it was called
something like "the last step to obsolete md". So the userspace approach
seems the way to go.

That leaves me with the following questions:

- The kernel 2.4 code detects ATARAIDs by usage of deep kernel knowledge
about the specific harddisk (depending on the phase of the moon, it uses
head/sect/cyl or LBA). Is all of this info available to userspace?

- Would an EVMS plugin or a simple script calling dmsetup be the way to
go? If I go the dmsetup route, is there any chance to get partition
detection on top of the ATARAID for free (by calling another dm tool)?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

