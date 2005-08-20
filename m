Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932794AbVHTBkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbVHTBkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 21:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbVHTBkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 21:40:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932794AbVHTBkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 21:40:39 -0400
Date: Fri, 19 Aug 2005 18:36:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.6.13-rc6-mm1
Message-Id: <20050819183600.49f620b0.akpm@osdl.org>
In-Reply-To: <430686EA.3000901@reub.net>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	<4305DCC6.70906@reub.net>
	<20050819103435.2c88a9f2.akpm@osdl.org>
	<430686EA.3000901@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> ...
> >> 4. PAM is complaining about "PAM audit_open() failed: Protocol not suppor
> >> ted" and I can't log in as any user including root.  I would have picked this 
> >> was a userspace problem, but it doesn't break with -rc5-mm1, yet reproduceably 
> >> breaks with -rc6-mm1.  Weird.
> > 
> > hm.  How come you're able to use the machine then?
> 
> Machine was booting up ok, and things were being written to syslog.  Rebooted 
> into -rc5-mm1 to investigate, and of course could boot into rc6-mm1 in single 
> user mode, test and bring services up one by one from there.  Having two boxes 
> helped too.
> 
> > Is it possible to get an strace of this failure somehow?
> 
> Not sure if this is needed anymore, as I found that the problem goes away when 
> I compile in kernel auditing.  This not required for -rc5-mm1.  Is that change 
> intended?
> 

Sounds wrong to me, especially if 2.6.13-rc6 doesn't do that.

David?
