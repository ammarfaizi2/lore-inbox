Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWB1RXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWB1RXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWB1RXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:23:51 -0500
Received: from main.gmane.org ([80.91.229.2]:57569 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751415AbWB1RXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:23:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergei Organov <osv@javad.com>
Subject: Re: o_sync in vfat driver
Date: Tue, 28 Feb 2006 20:23:24 +0300
Message-ID: <du20uc$ug1$1@sea.gmane.org>
References: <op.s5lq2hllj68xd1@mail.piments.com>
	<20060227132848.GA27601@csclub.uwaterloo.ca>
	<1141048228.2992.106.camel@laptopd505.fenrus.org>
	<1141049176.18855.4.camel@imp.csi.cam.ac.uk>
	<1141050437.2992.111.camel@laptopd505.fenrus.org>
	<1141051305.18855.21.camel@imp.csi.cam.ac.uk>
	<op.s5ngtbpsj68xd1@mail.piments.com>
	<Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com>
	<op.s5nm6rm5j68xd1@mail.piments.com>
	<Pine.LNX.4.61.0602280745500.9291@chaos.analogic.com>
	<20060228151856.GB27601@csclub.uwaterloo.ca>
	<Pine.LNX.4.61.0602281110460.4497@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> On Tue, 28 Feb 2006, Lennart Sorensen wrote:
>
>> On Tue, Feb 28, 2006 at 08:10:44AM -0500, linux-os (Dick Johnson) wrote:
>>>
>>> On Mon, 27 Feb 2006 col-pepper@piments.com wrote:
>>>
>>>> On Mon, 27 Feb 2006 22:32:07 +0100, linux-os (Dick Johnson)
>>>> <linux-os@analogic.com> wrote:
>>>>
>>>>> Flash does not get zeroed to be written! It gets erased, which sets all
>>>>> the bits to '1', i.e., all bytes to 0xff.
>>>>
>>>> Thanks for the correction, but that does not change the discussion.
>>>>
>>>>> Further, the designers of
>>>>> flash disks are not stupid as you assume. The direct access occurs
>>>>> to static RAM (read/write stuff).
>>>>
>>>> I'm not assuming anything . Some hardware has been killed by this issue.
>>>> http://lkml.org/lkml/2005/5/13/144
>>>
>>> No. That hardware was not killed by that issue. The writer, or another
>>> who had encountered the same issue, eventually repartitioned and
>>> reformatted the device. The partition table had gotten corrupted by
>>> some experiments and the writer assumed that the device was broken.
>>> It wasn't.
>>>
>>> Also, if you read other elements in this thread, you would have
>>> learned about something that has become somewhat of a red herring.
>>>
>>> It takes about a second to erase a 64k physical sector. This is
>>> a required operation before it is written. Since the projected
>>> life of these new devices is about 5 to 10 million such cycles,
>>> (older NAND flash used in modems was only 100-200k) the writer
>>> would have to be running that "brand new device" for at least
>>> 5 million seconds. Let's see:
>>
>> How come I can write to my compact flash at about 2M/s if you claim it
>> takes 1s to erase a 64k sector?  Somehow I think your number is much too
>> high.  Or it can do multiple erases at the same time.
>>
>> Also the 5 to 10 million is a lot higher than the numbers the makers of
>> the compact flash cards I use claim.
>>
>
> Here is an instrumented erase function on a driver that rewrites
> the first sector of a BIOS ROM. Unlike the Flash DISKS, the
> BIOS ROM has no buffering in static RAM so you can gustimate
> the actual time to erase............

BIOS ROM is never NAND FLASH, it's most probably NOR FLASH, and FLASH
DISKS are most probably NAND FLASH. NOR and NAND are very different
technologies. You compare apples and oranges, -- static RAM has nothing
to do with that.

-- Sergei.

