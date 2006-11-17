Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933627AbWKQOmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933627AbWKQOmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933629AbWKQOmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:42:14 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:9365 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S933627AbWKQOmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:42:13 -0500
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [ckrm-tech] [RFC][PATCH 5/8] RSS controller task migration support
Cc: balbir@in.ibm.com, ckrm-tech@lists.sourceforge.net, dev@openvz.org,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       rohitseth@google.com
Message-Id: <20061117144206.3013D1B6A2@openx4.frec.bull.fr>
Date: Fri, 17 Nov 2006 15:42:06 +0100 (CET)
From: Patrick.Le-Dot@bull.net (Patrick.Le-Dot)
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/11/2006 15:49:07,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/11/2006 15:49:08,
	Serialize complete at 17/11/2006 15:49:08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 14:05:13 +0000
> ...
> There are two reasons for wanting memory guarantees
> 
> #1      To be sure a user can't toast the entire box but just their own
>         compartment (eg web hosting)

Well, this seems not a situation to add a guarantee to this user
but a limit...

> ...
> #2      To ensure all apps continue to make progress

or to ensure that a job is ready to work without to have to pay the
cost of a lot of pagination in...


>> If the limit is a "hard limit" then we have implemented reservation and
>> this is too strict.
>
> Thats fundamentally a judgement based on your particular workload and
> constraints.
Nop.
You can read this on the wiki page...

I'm just saying that the implementation of guarantee with limits seems to
be not enough for #2.

> If I am web hosting then I don't generally care if my end
> users compartment blows up under excess load, I care that the other 200
> customers using the box don't suffer and all phone me to complain.

I agree : limit is necessary and should be a "hard limit" (even if the
controler needs an internal threeshold like a "soft limit" to decide to
wakeup the kswapd).
But this is not the topic (not yet:-)

Patrick
