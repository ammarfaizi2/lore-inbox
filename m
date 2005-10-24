Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVJXWLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVJXWLV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 18:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVJXWLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 18:11:20 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:48111 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S1750838AbVJXWLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 18:11:18 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: dlang@dlang.diginsite.com
References: dlang@dlang.diginsite.com
Date: Mon, 24 Oct 2005 15:09:49 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally
 attachedPHYs)
In-Reply-To: <435A7BA9.4090502@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.62.0510241506130.7918@qynat.qvtvafvgr.pbz>
References: <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com>
 <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com>
 <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com>
 <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com>
 <435A1793.1050805@s5r6.in-berlin.de> <20051022105815.GB3027@infradead.org>
 <435A7BA9.4090502@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2005, Stefan Richter wrote:

> Christoph Hellwig wrote:
>> On Sat, Oct 22, 2005 at 12:42:27PM +0200, Stefan Richter wrote:
>>> A. Post mock-ups and pseudo code about how to change the core, discuss.
>>> B. Set up a scsi-cleanup tree. In this tree,
>>>     1. renovate the core (thereby break all command set drivers and
>>>        all transport subsystems),
>> 
>> No way.  Doing things from scatch is a really bad idea.  See how far we 
>> came
>> with Linux 2.6 scsi vs 2.4 scsi without throwing everything away and break 
>> the
>> world.  Please submit changes to fix _one_ thing at a time and fix all 
>> users.
>> Repeat until done or you don't care anymore.
>
> I agree with you. Alas my wording was misunderstandable und obviously carried 
> a wrong tone.
>
> I did not say "replace the core" in step 1. Also, the breakage which I refer 
> to in step 1 would have to be immediately corrected in step 2 (although not 
> for the whole subsystem at once, to allow for a fast cycle of validation of 
> what happened in step 1). Furthermore I specifically said that most steps may 
> (let me add: and should) overlap.

Stefan,
   we are supposed to be on a 2-month release cycle, with all major changes 
going in in the first two weeks of that cycle. This timeframe doesn't 
leave you any noticable time to implement your steps seperatly (and zero 
testing between them). as a result, in practice your proposal amounts to a 
big-bang approach, and/or results in releases that are known-broken.

and while you suggest putting this in -mm, remember that the -mm kernel 
needs to be useable so that people can test it, and it is on the same 
schedule as the main kernel so again you can't have known-broken things 
(of this scale) there either.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
