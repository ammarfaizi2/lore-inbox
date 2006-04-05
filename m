Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWDEShV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWDEShV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 14:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWDEShV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 14:37:21 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:37081 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932067AbWDEShU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 14:37:20 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>
Cc: "'linux mailing-list'" <linux-kernel@vger.kernel.org>
Subject: RE: RSS Limit implementation issue
Date: Wed, 5 Apr 2006 13:50:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcZY3XMtohu5H7auTKWv616v7Z3UKwAA5ABw
In-Reply-To: <4432C8E6.6010301@tmr.com>
Message-ID: <EXCHG2003uNY1SWoBDy00000392@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 05 Apr 2006 18:29:35.0689 (UTC) FILETIME=[E3F1B390:01C658DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> After thinking about this, I have the opinion that if an RSS 
> limit is working it would be a hard limit. The alternative is 
> a process which gets large and then when memory pressure 
> increases the oversize process either causes a lot of 
> swapping or worse yet ties up a lot of memory if swap rate is limited.
> 
> There are many ways to tune Linux badly, adding one more will 
> not add much to the pain if the default is off. The values 
> available to a normal users might be limited to prevent the 
> most obvious bad choices. Or a corresponding option could be 
> provided to take corrective action for a process with RSS set 
> (to any value) and swap rate high.
>

I think the mistake on VMS was that the defaults were horribly
low and where not changed when machines got more memory, there
may be some situations where an RSS limit is wanted, but
the kernel would need to be implementing it, the process has no
control over its RSS.

I can see even having a min RSS that a process won't get swapped
below being probably more useful, as certain interactive process
on either a server or a desktop might want to not be swapped out below
a certain level, even if other processes suffer.   I would suspect
that I would set a min limit on certain applications that needed
decent response, and had got previously bad response to because 
of swapping, though something in the kernel would need to deal
with a potential overcommitting of memory via this method, and 
deal with the associated deadlock.

                                 Roger

