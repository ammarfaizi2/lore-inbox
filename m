Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758277AbWK2Aul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758277AbWK2Aul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758282AbWK2Auk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:50:40 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:5966 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1758277AbWK2Auk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:50:40 -0500
Message-ID: <456CD957.2020002@oracle.com>
Date: Tue, 28 Nov 2006 16:50:31 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, aia21@cantab.net
Subject: Re: [PATCH 1/2] lib + ntfs: let modules force HWEIGHT
References: <20061128140840.f87540e8.randy.dunlap@oracle.com> <20061128164538.d95e8498.akpm@osdl.org>
In-Reply-To: <20061128164538.d95e8498.akpm@osdl.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 28 Nov 2006 14:08:40 -0800
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> NTFS (=m) uses hweight32(), but that function is only linked
>> into the kernel image if it is used inside the kernel image,
>> not in loadable modules.  Let modules force HWEIGHT to be
>> built into the kernel image.  Otherwise build fails:
>>
>>   Building modules, stage 2.
>>   MODPOST 94 modules
>> WARNING: "hweight32" [fs/ntfs/ntfs.ko] undefined!
>>
>> Yes, I'd certainly prefer for this to be more automated rather than
>> forced by each module that needs it.
> 
> Perhaps we should just put it in lib-y and remove CONFIG_GENERIC_HWEIGHT.
> It's either part of the API or it ain't.

Yes, that matches how I feel about it, but I expected some disagreement
(from elsewhere, not from you).

I'll send another patch later.  Replacement patch OK?  (vs. update)

-- 
~Randy
