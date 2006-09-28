Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWI1BuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWI1BuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWI1BuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:50:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7379 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965101AbWI1BuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:50:18 -0400
Message-ID: <451B2A58.9010603@garzik.org>
Date: Wed, 27 Sep 2006 21:50:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] device_for_each_child(): kill pointless warning noise
References: <20060928010518.GA25865@havoc.gtf.org> <20060927184200.7d7b9cc2.akpm@osdl.org>
In-Reply-To: <20060927184200.7d7b9cc2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 27 Sep 2006 21:05:18 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> As the last patch demonstrated, it is quite valid for a caller to ignore
>> the return value of device_for_each_child(), given that the return value
>> is wholly dependent on the actor -- which in practice often has a
>> hardcoded return value.
> 
> Yes, but almost all of the instances which you found are flat-out *wrong*. 
> They're returning 0 or 1 at random places in the callchain because they're
> calling intermediate void-returning functions which are themselves dropping
> error codes on the floor instead of returning them.

"almost all"  Thus it is wrong to _force_ the usage model on the caller.

It should be obvious that a simple search need not _require_ a dummy 
return value, that is promptly ignored.

See previous email for examples.

	Jeff



