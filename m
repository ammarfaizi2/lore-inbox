Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269696AbUJVODC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269696AbUJVODC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269935AbUJVODC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:03:02 -0400
Received: from magic.adaptec.com ([216.52.22.17]:25047 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S269696AbUJVOC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:02:56 -0400
Message-ID: <41791302.5030305@adaptec.com>
Date: Fri, 22 Oct 2004 10:02:42 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "K.R. Foley" <kr@cybsft.com>, "J.A. Magallon" <jamagallon@able.es>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
References: <1097178019.24355.39.camel@localhost> <1097188963l.6408l.2l@werewolf.able.es> <41661013.9090700@cybsft.com> <41668346.6090109@adaptec.com> <20041022135800.GA8254@elte.hu>
In-Reply-To: <20041022135800.GA8254@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2004 14:02:52.0543 (UTC) FILETIME=[D263E8F0:01C4B83F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried this with the latest scsi-misc-2.6 tree?  The PCI
table patches are there.

If you have _and_ it still does not work, can you send output of
"lspci -vn"?

Thanks,
	Luben


Ingo Molnar wrote:
> * Luben Tuikov <luben_tuikov@adaptec.com> wrote:
> 
> 
>>>>>backing out bk-scsi.patch seems to fix it.  I believe this worked in
>>>>>2.6.9-rc3-mm2.
> 
> 
>>>Mine doesn't without backing out those patches :) See my other post 
>>>about this.
>>>
>>>04:05.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
>>>04:05.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
>>
>>You can see you have different chips.  It's the IDs.
>>I'll come up with something shortly.
> 
> 
> Same adapter, same problem here:
> 
>  03:04.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
>  03:04.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> 
> any patch i could try (other than backing out the whole SCSI patch)? 
> 
> 	Ingo

