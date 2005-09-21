Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVIUSF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVIUSF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVIUSF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:05:56 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:9374 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751343AbVIUSFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:05:55 -0400
Message-ID: <4331A0DA.5030801@engr.sgi.com>
Date: Wed, 21 Sep 2005 11:05:14 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, zh-tw, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com> <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 21 Sep 2005, Jay Lan wrote:
> 
>>It is not really an issue of out-of-tree accounting package. The
>>system accounting is based on very old technology and needs improvement.
>>The issue we face is not an issue of one particular accounting package.
>>
>>I think the best approach would be to wrap the mm usage accounting
>>in a new CONFIG_ENHANCED_SYS_ACCT and leave it OFF by default so that
>>people can still get the minimal accounting with
>>CONFIG_BSD_PROCESS_ACCT.
> 
> 
> Yes, please: that sounds right.  With macros which dissolve to nothing
> when it's off, to avoid #ifdef CONFIG_....s throughout the source.c.
> #ifdef around the mm fields themselves?  Probably best that way.

Yes, that was the plan.

> 
> Still need a pointer in the Kconfig to some project that uses these.
> 
> Still sceptical that hiwater_vm and hiwater_rss are the magic
> missing numbers which bring system accounting into the 21st century:
> more to come?

Nah, the hiwater things were part of my enhanced accounting patches.
The io part was done as a macro as we talked about now. These are
the mm part.

System accounting improvement is needed because those accouting
information were needed and used at real customer sites.

So, yes, the basic system accounting code (ie, BSD) needs
improvement, and, no, i am done with sys acct data collection.

Thanks,
  - jay


> 
> Thanks,
> Hugh

