Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUDAF2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 00:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUDAF2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 00:28:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60035 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262322AbUDAF2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 00:28:22 -0500
Message-ID: <406BA867.1070508@pobox.com>
Date: Thu, 01 Apr 2004 00:28:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Device mapper devel list <dm-devel@redhat.com>,
       Thomas Horsten <thomas@horsten.com>, medley@lists.infowares.com
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <20040321074711.GA13232@devserv.devel.redhat.com> <405D9CDA.6070107@gmx.at> <405F3B1C.3030500@gmx.net> <405F3EA8.6060606@pobox.com> <406B8A3D.9030405@gmx.net>
In-Reply-To: <406B8A3D.9030405@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Jeff Garzik wrote:
> 
>>Carl-Daniel Hailfinger wrote:
>>
>>
>>>Wilfried Weissmann wrote:
>>>
>>>
>>>>Arjan van de Ven wrote:
>>>>
>>>>
>>>>
>>>>>On Sat, Mar 20, 2004 at 07:23:01PM -0700, Kevin P. Fleming wrote:
>>>>>
>>>>>
>>>>>
>>>>>>Jeff Garzik wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>>So go ahead, and I'll lend you as much help as I can.  I have the
>>>>>>>full Promise RAID docs, and it seems like another guy on the lists
>>>>>>>has full Silicon Image "medley" RAID docs...
>>>
>>>
>>>Jeff: May I request your docs?
>>
>>Unfortunately not, but I can get you in touch with somebody at Promise
>>who can.  They're definitely interested in working with the open source
>>community.  Not public...
> 
> 
> Could you please send me the contact information via private mail?
> Thanks.

Will do.


>>>I'll use your work as a foundation. First step is integrating detection
>>>for non-HPT arrays. If the code looks too messy after that, I still can
>>>refactor it.
>>>
>>>As soon as I have some code to get at least PDCRAID working, I'll post
>>>again.
>>
>>
>>Feel free to ask me questions, too.
> 
> 
> OK. First question: calc_pdcblock_offset calculates the superblock
> location based on capacity, sectors and heads. However, the same machine
> which showed 255 heads under Kernel 2.4 now shows only 16 heads and some
> of the hardcoded location calculation routines may fail. Is there a
> userspace generic method for finding the right sector?
> (It works sometimes for me.)

The standard method one uses to calculate cyl/head/sect in ATA, AFAIK. 
If that changes between 2.4 and 2.6, that sounds like a bug unrelated to 
the code you're writing...

	Jeff



