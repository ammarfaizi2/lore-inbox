Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUANVQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUANVOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:14:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:36276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264095AbUANVOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:14:36 -0500
Date: Wed, 14 Jan 2004 13:12:29 -0800
From: Greg KH <greg@kroah.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Clay Haapala <chaapala@cisco.com>, Nuno Silva <nuno.silva@vgertech.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
Message-ID: <20040114211229.GB6650@kroah.com>
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com> <20040114171527.GB5472@kroah.com> <40058086.5000106@nortelnetworks.com> <yqujn08q46ct.fsf@chaapala-lnx2.cisco.com> <4005AAD3.4010301@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4005AAD3.4010301@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 03:47:15PM -0500, Chris Friesen wrote:
> Clay Haapala wrote:
> 
> >Is the act of printing/syslogging a rule in an of itself? 
> 
> I haven't looked at the capabilities in a while.  Can you specify a 
> default rule if nothing else matches?

The "default rule" is to use the kernel name to name the device.  That
one is built in.

> Can you, in one rule, specify another rule?  (Kind of like iptables
> jump targets).

No.

> If so, then this would allow massive flexibility.

And massive complexity :)

Why would you want to have a rule specify another (in the current
syntax)?  These rules aren't that complex, and anything that does grow
to be complex should be shoved out into a separate script/program that a
rule can then call.

Does this help?

thanks,

greg k-h
