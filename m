Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUKJBbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUKJBbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUKJBbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:31:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:26776 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261822AbUKJBax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:30:53 -0500
Message-ID: <41916ECB.4070102@engr.sgi.com>
Date: Tue, 09 Nov 2004 17:28:43 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech <lse-tech@lists.sourceforge.net>
CC: guillaume.thouvenin@bull.net, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [Lse-tech] Re: [PATCH 2.6.9 0/2] new enhanced accounting data
 collection
References: <418FC082.8090706@engr.sgi.com> <1100007698.18813.12.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1100007698.18813.12.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at the latest 2.6.10-rc1-mm4, and found the eop handler
acct_process(code) used to be invoked per process from do_exit()
has been hijacked :) to become a per group thing. I would still like
to have a per process eop handling. How about BSD and ELSA?

Thanks,
  - jay


Guillaume Thouvenin wrote:
> On Mon, 2004-11-08 at 19:52, Jay Lan wrote:
> 
>>In earlier round of discussion, all partipants favored  a common
>>layer of accounting data collection.
>>
>>This is intended to offer common data collection method for various
>>accounting packages including BSD accounting, ELSA, CSA, and any other
>>acct packages that use a common layer of data collection.
> 
> 
> I found this great. Now I think, as you already pointed, we need to
> modify the end-of-process handling. Currently I use the BSD structure
> but this part of ELSA can be changed very easily.
> 
> Regards, 
> Guillaume 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

