Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbUJ3IxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUJ3IxD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 04:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUJ3IxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 04:53:03 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34946 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261720AbUJ3Iw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 04:52:59 -0400
Date: Sat, 30 Oct 2004 17:58:45 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
In-reply-to: <418354C0.3060207@tebibyte.org>
To: Chris Ross <chris@tebibyte.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Message-id: <418357C5.4070304@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3)
 Gecko/20040910
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com>
 <20041028120650.GD5741@logos.cnet> <41824760.7010703@tebibyte.org>
 <41834FE7.5060705@jp.fujitsu.com> <418354C0.3060207@tebibyte.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:

> 
> 
> Hiroyuki KAMEZAWA escreveu:
> 
>> How about this fix ?
>> I don't know why this is missng ....
> 
> 
> Instead of, or as well as Rik's fix?
> 

Both of Rik's and this will be needed, I think.

> Regards,
> Chris R.
> 
zone->free_area[order]->nr_free is corrupted, this patch fix it.

It looks there is no area->nr_free++ code during freeing pages, now.


Kame <kamezawa.hiroyu@jp.fujitsu.com>

