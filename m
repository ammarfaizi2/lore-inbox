Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWGIAsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWGIAsO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 20:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWGIAsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 20:48:13 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:53076 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030432AbWGIAsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 20:48:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oUMnBaUd1t2J2tT5XGWPZDhB6nlX6atjeTiXtUH1xj0BVIrV5r3iKreUikfbPaBrORbVgxYAFPmGr6P043Cp+YyMDekyWYdBmIArtXOG1oM4PoDTeKJ54lCJeQ/+HOvesiPUmRVZf+/VvS9UK8ANgprWvi7N4YrF20VV42ZbiaU=  ;
Message-ID: <20060709004812.5968.qmail@web31802.mail.mud.yahoo.com>
Date: Sat, 8 Jul 2006 17:48:12 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <44AE9584.4040300@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jeff Garzik <jeff@garzik.org> wrote:
> Your patch increases the size of a key data structure -- task struct -- 
> for all users on all platforms, even when there are _no_ users currently 
> in the kernel.
> 
> It is thus wasted space, for all users on all platforms.
> 
> Linux development doesn't work like this.  We don't know the future, 
> until it happens.

:-)  I love your logic...  Can I quote you on this?

Your thinking: "We don't know the future, until it happens",
leaves you unprepared for that future when it actually happens.

> Thus, this patch is appropriate when there are real users in the kernel, 
> and not before.

Impeccable logic, wouldn't you say?

How would you know that there will _not_ be any users unless you
give them the opportunity to use it?

Your logic is not only the chicken-and-the-egg problem but is also
the classical example in political history:
   Since there are no current users of "facility X", don't give
   it to the people.

How would you know?  How?  When it is not available in the first place?

I know subsystems' developers go through _great_ strives to keep
the kernel thread names to fit 15+1 chars.*  This is why you don't
see any "users".

If TASK_COMM_LEN _were_ 19+1 chars, I bet you users of that facility
will spring up.

    Luben

* At least that was the case for me 6 years ago when developing iSCSI
code... Those iSCSI threads can certainly make use of something larger
than 15+1 chars.  And it's not only iSCSI.  You have to keep an
 _open mind_ to the future.

