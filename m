Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVESNNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVESNNO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVESNNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:13:14 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:16570 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262414AbVESNNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:13:09 -0400
Subject: Re: Resent: BUG in RT 45-01 when RT program dumps core
From: Steven Rostedt <rostedt@goodmis.org>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: kus Kusche Klaus <kus@keba.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1116506317.17833.34.camel@ibiza.btsn.frna.bull.fr>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
	 <1116503763.15866.9.camel@localhost.localdomain>
	 <1116506317.17833.34.camel@ibiza.btsn.frna.bull.fr>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 09:12:37 -0400
Message-Id: <1116508357.15866.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 14:38 +0200, Serge Noiraud wrote:
> > Ingo,
> > 
> > Did you get my patch to fix the kstop_machine yielding problem?
> > 
> > -- Steve
> 
> Does it solve this problem ? is it the same ? I'm in RT 47-03.
> If yes, I'm interested in this patch.
> ...

Yes it does. Actually, all it does is allow kstopmachine to call yield
without the bug message.  I looked into the logic of kstopmachine, and
it is perfectly fine to call yield there. So I added a rt_yield function
to allow for places that it is OK for a RT task to call yield without
showing that message.

I found my patch here: (It's a -p0 patch)

http://seclists.org/lists/linux-kernel/2005/May/att-2111/rt-yeild.patch__charset_us-ascii


-- Steve



