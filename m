Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUGGFlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUGGFlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 01:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264914AbUGGFlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 01:41:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22403 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264913AbUGGFks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 01:40:48 -0400
Message-ID: <40EB8CCF.3080804@pobox.com>
Date: Wed, 07 Jul 2004 01:40:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andre Hedrick <andre@linux-ide.org>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
References: <20040610164135.GA2230@bounceswoosh.org> <Pine.LNX.4.10.10406260118220.19080-100000@master.linux-ide.org> <20040628181835.GA14632@bounceswoosh.org> <20040702082930.GN1114@suse.de>
In-Reply-To: <20040702082930.GN1114@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Jun 28 2004, Eric D. Mudama wrote:
> 
>>On Sat, Jun 26 at  1:31, Andre Hedrick wrote:
>>
>>>Eric,
>>>
>>>There is no need for a new opcode.
>>>The behavior is simple and trivial to support.
>>>
>>>If standard flush_cache/ext were to behave just like standard data_in
>>>taskfile register setup, yet use a non_data command state machine it would
>>>be done.
>>>
>>>Special case would be deal with LBA Zero and this would have to behave
>>>like a complete device flush.  Since flushing sector zero is not generally
>>>done ... well this would go into a design debate and it is not my issue
>>>nor my desire to enter one today.
>>>
>>>28-bit would support max 256 sectors
>>>48-bit would support max 65536 sectors
>>>
>>>Anyone could write this simple proposal to T13 for SATA and T10 for SAS.
>>
>>True, that would work just as well.
>>
>>But as you mention, it isn't necessarilly what people want or think
>>they want or could actually use...
> 
> 
> It would work, but it's still a lot nicer to not have to issue an extra
> command to flush the range.


True, but you also have to think about which is easier for drive vendors 
to implement (without screwing up the implementation :)), and which is 
more likely get through T13...

	Jeff


