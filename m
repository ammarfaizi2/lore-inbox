Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272650AbTG3Bz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272615AbTG3Bz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:55:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:22229 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272650AbTG3BzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:55:25 -0400
Date: Tue, 29 Jul 2003 18:55:23 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, notting@redhat.com, arjanv@redhat.com,
       torvalds@osdl.org, shemminger@osdl.org, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
Message-ID: <20030730015523.GB5228@kroah.com>
References: <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org> <20030727193919.832302C450@lists.samba.org> <20030727214701.A23137@devserv.devel.redhat.com> <20030727201242.A29448@devserv.devel.redhat.com> <1059392321.15458.23.camel@dhcp22.swansea.linux.org.uk> <20030730063310.70b5c794.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730063310.70b5c794.rusty@rustcorp.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 06:33:10AM +1000, Rusty Russell wrote:
> Agreed that'd be kinda silly.  But I was "educated" earlier that driver
> loading shouldn't fail just because hardware is missing, due to hotplug.
> 
> Is this wrong?

No, this is not wrong.  Older pci drivers would refuse to load if they
didn't find their pci device in the system at that moment in time.  All
pci drivers converted to the "new" api (new is a very relative term,
some 3 years old now...) will load just fine even if their devices are
not present.

Hope this helps,

greg k-h
