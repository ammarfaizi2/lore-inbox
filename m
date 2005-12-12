Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVLLTDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVLLTDU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 14:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVLLTDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 14:03:20 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:27338 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932142AbVLLTDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 14:03:20 -0500
Date: Mon, 12 Dec 2005 11:02:53 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Christoph Hellwig <hch@infradead.org>
cc: Michal Feix <michal@feix.cz>, linux-kernel@vger.kernel.org
Subject: Re: [SCSI] SCSI block devices larger then 2TB
In-Reply-To: <20051207123519.GA17414@infradead.org>
Message-ID: <Pine.LNX.4.62.0512121057070.267@qynat.qvtvafvgr.pbz>
References: <4396B795.1000108@feix.cz> <20051207123519.GA17414@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Christoph Hellwig wrote:

> On Wed, Dec 07, 2005 at 11:21:09AM +0100, Michal Feix wrote:
>> Greetings!
>>
>> Current aic79xxx driver doesn't see SCSI devices larger, then 2TB. It
>> fails with READ CAPACITY(16) command. As far as I can understand, we
>> already have LBD support in kernel for some time now. So it's only the
>
>> drivers, that need to be fixed? LSI driver is the only one I found
>> working with devices over 2TB; I couldn't test any other driver, as I
>> don't have the hardware. Is it really so bad, that only LSI chipset
> and
>> maybe few others are capable of seeng such devices?
>
> I definitly works fine with Qlogic parallel scsi and fibrechannel and
> emulex
> fibre channel controllers aswell as lsi/engenio megaraid controllers.
>
> It looks like aci79xx is just broken in that repsect. Unfortunately the
> driver doesn't have a proper maintainer, we scsi developers put in fixes
> and cleanups but we don't have the full documentation to fix such
> complicated
> issue.  If you have a support contract with Adaptec complain to them.

I was at a BOF at LISA last week on this subject, the guy running it said 
that the common ultra320 chip used for parallel scsi doesn't implment READ 
CAPACITY(16), but instead implemnets a propriatary READ CAPACITY(12) which 
allows you to break the 2TB limit.

I asked him to send the patch that he's been maintaining seperatly (and 
providing to his customers, he's a storage hardware vendor) to the list to 
get integrated.

I'll see if I have any notes with his address on them, or you could check 
the BOF schedule online to see if it got listed there.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

