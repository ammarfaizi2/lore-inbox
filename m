Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265610AbUAPSLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265612AbUAPSLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:11:50 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:48595 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265610AbUAPSLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:11:48 -0500
Date: Fri, 16 Jan 2004 10:10:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Joe Thornber <thornber@redhat.com>, Arjan van de Ven <arjanv@redhat.com>,
       Prashanth T <prasht@in.ibm.com>, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwlock_is_locked undefined for UP systems
Message-ID: <20040116181052.GJ1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Nikita Danilov <Nikita@Namesys.COM>,
	Joe Thornber <thornber@redhat.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Prashanth T <prasht@in.ibm.com>, rml@tech9.net,
	linux-kernel@vger.kernel.org
References: <4007EAE7.2030104@in.ibm.com> <1074261350.4434.4.camel@laptop.fenrus.com> <20040116145311.GD1740@reti> <16391.65470.831998.936394@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16391.65470.831998.936394@laputa.namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 06:14:06PM +0300, Nikita Danilov wrote:
> it should now be changed to the
> 
> void foo_locked(struct bar *obj)
> {
> #ifdef CONFIG_SMP
>     BUG_ON(!rwlock_is_locked(&obj->lock));
> #endif
>     /* proceed with obj. */
> }

You forgot preempt... ;)
