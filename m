Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVETTsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVETTsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVETTsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:48:37 -0400
Received: from soundwarez.org ([217.160.171.123]:64733 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261561AbVETTsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:48:31 -0400
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
From: Kay Sievers <kay.sievers@vrfy.org>
To: dtor_core@ameritech.net
Cc: Tom Rini <trini@kernel.crashing.org>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <d120d5000505201207227edf4a@mail.gmail.com>
References: <20050519164323.GK3771@smtp.west.cox.net>
	 <1116573175.7647.4.camel@dhcp-188.off.vrfy.org>
	 <20050520171808.GM3771@smtp.west.cox.net>
	 <1116611802.12975.19.camel@dhcp-188>
	 <d120d5000505201207227edf4a@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 20 May 2005 21:48:13 +0200
Message-Id: <1116618493.12975.48.camel@dhcp-188>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 14:07 -0500, Dmitry Torokhov wrote:
> On 5/20/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> > 
> > Well, it doesn't depend on "make it private" it depends on Dimitry, who
> > wanted to tweak our patch for the input layer. But we wait for weeeks
> > for that. The SUSE kernel already ships a driver-core input layer
> > without the /sbin/hotplug stuff.
> >
> 
> Kay,
> 
> I am sorry for being slow with these patches but I really do spend all
> time that I can on kernel.

Oh well, I know that problem. :) We need to move completely away from
unmanaged kernel-forked processes in the hotplug area. SUSE 9.3 already
ships a udevd that listens only on netlink for hotplug messages
and /proc/sys/kernel/hotplug is set to "".
Hannes converted the input layer to a input_device class to get the
event through netlink. Maybe you can have a second look at it, so that
we can get that thing upstream soon to fix the last broken hotplug-user
and make hotplug_path finally private.

Thanks,
Kay


