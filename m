Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbUBXRSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbUBXRRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:17:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37566 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262307AbUBXRKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:10:45 -0500
Message-ID: <403B8587.3030009@pobox.com>
Date: Tue, 24 Feb 2004 12:10:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Henrik Gustafsson <henrik.gustafsson@fnord.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise SATA driver
References: <200402241110.07526.andrew@walrond.org> <20040224154446.GA28720@ee.oulu.fi> <403B73E3.80100@pobox.com> <200402241630.36105.andrew@walrond.org> <403B8028.1060700@pobox.com> <opr3vv7qk4uwbm4s@localhost>
In-Reply-To: <opr3vv7qk4uwbm4s@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Gustafsson wrote:
> On Tue, 24 Feb 2004 11:47:36 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> Andrew Walrond wrote:
>>
>>> I take it the software raid thing wasn't part of the gpl'ed driver, 
>>> and isn't something that is likely to happen?
>>
>>
>>
>> In 2.4, RAID0 and RAID1 are supported via the pdcraid driver.
>>
>> In 2.6, Promise software RAID support does not exist.  In 
>> conversations with Promise, we all agreed to encourage and support the 
>> standard Linux RAID, md.
>>
>>     Jeff
> 
> 
> Does that apply to the FastTrack S150 SX4 aswell? The hardware 
> XOR-engine will not be used?
> What about the onboard cache?


I'm glad you asked.

The SX4 is a very different story.  The hardware XOR engine and on-board 
cache are not currently used, but they will be in the future.

For the TX series, there is no on-board cache, so hardware XOR engine 
isn't very useful.  For the SX series, it is very useful.

Promise did some neat stuff with the SX4...  so neat it takes some 
thinking to figure out how to best implement it in Linux :)

	Jeff



