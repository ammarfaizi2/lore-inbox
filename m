Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269001AbUJKOJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269001AbUJKOJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268999AbUJKOJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:09:01 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6803 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268979AbUJKOF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:05:28 -0400
Message-ID: <416A92B9.2020603@sgi.com>
Date: Mon, 11 Oct 2004 09:03:37 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Colin Ngam <cngam@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41644301.9EC028B3@sgi.com> <20041006195424.GF25773@cup.hp.com> <200410061327.28572.jbarnes@engr.sgi.com> <20041006204832.GB26459@cup.hp.com> <20041006210525.GI16153@parcelfarce.linux.theplanet.co.uk> <41645BDE.E9732310@sgi.com> <4166AF3D.9080808@sgi.com> <20041009222011.GA10422@cup.hp.com> <4169A508.84FB19C7@sgi.com>
In-Reply-To: <4169A508.84FB19C7@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,


We came to a resolution on the pci_root-ops issue, Jesse is OK with the code, Jes and Christoph are 
fine with the qla mod. I've added a couple of fixes from us as well as removing a redundant check 
pointed out in the review - see the full list below. So the code is ready to go.

Can you take this now Tony ?

Thanks,
-- Pat

ftp://oss.sgi.com/projects/sn2/sn2-update/001-kill-files
ftp://oss.sgi.com/projects/sn2/sn2-update/002-add-files
ftp://oss.sgi.com/projects/sn2/sn2-update/003-qla-mod
ftp://oss.sgi.com/projects/sn2/sn2-update/004-sn_hwperf               - fix from us
ftp://oss.sgi.com/projects/sn2/sn2-update/005-redundant-check-killed  - removed rundundant check
ftp://oss.sgi.com/projects/sn2/sn2-update/006-sn_set_affinity_irq     - fix from us
ftp://oss.sgi.com/projects/sn2/sn2-update/007-root-ops                - make pci_root_ops non-static


Colin Ngam wrote:
> Grant Grundler wrote:
> 
> Hi Tony,
> 
> Jesse is alright with this issue too.  Unfortunately, I believe his 
> email may not have gotten out of SGI because we were having email 
> problems on Friday.
> 
> Thanks gents.
> 
> colin
> 
>> On Fri, Oct 08, 2004 at 10:16:13AM -0500, Colin Ngam wrote:
>> > Now, if we can remove the static from pci_root_ops, I can use it in
>> > io_init.c, that would be cleanest and that was what we started with.
>>
>> willy already agreed:
>> http://marc.theaimsgroup.com/?l=linux-ia64&m=109709521721980&w=2 
>> <http://marc.theaimsgroup.com/?l=linux-ia64&m=109709521721980&w=2>
>>
>> I'm ok with it too.
>>
>> hth,
>> grant
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>

