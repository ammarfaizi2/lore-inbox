Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUFQUwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUFQUwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUFQUwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:52:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43472 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263003AbUFQUwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:52:10 -0400
Date: Thu, 17 Jun 2004 13:51:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: zwane@fsmlabs.com, greg@kroah.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] fix bridge sysfs improperly initialised knobject
Message-Id: <20040617135142.17a2f820.davem@redhat.com>
In-Reply-To: <20040617134636.216f430e@dell_ss3.pdx.osdl.net>
References: <Pine.LNX.4.58.0406161247140.1944@montezuma.fsmlabs.com>
	<20040617134636.216f430e@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 13:46:36 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> > -struct subsystem bridge_subsys = {
> > -	.kset = { .hotplug_ops = NULL },
> > -};
> > +decl_subsys_name(bridge, net_bridge, NULL, NULL);
> > 
> >  void br_sysfs_init(void)
> >  {
> 
> Yes, this would get rid of the name, but then wouldn't bridge show up
> as top level subsystem /sys/bridge. 
> 
> Is there no way to register without causing bogus hotplug events?

Ok, for now I'm putting the change in, since 2.6.8 is not "around
the corner" we'll have time to put a better fix into the tree.
