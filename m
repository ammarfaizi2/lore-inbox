Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVARTaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVARTaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVARTaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:30:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:59780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261401AbVARTaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:30:16 -0500
Date: Tue, 18 Jan 2005 11:30:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "Serge E. Hallyn" <hallyn@cs.wm.edu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Fix audit control message checks
Message-ID: <20050118113007.Y24171@build.pdx.osdl.net>
References: <20050115200734.GA22087@escher.cs.wm.edu> <1106055058.18274.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1106055058.18274.57.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Jan 18, 2005 at 08:30:58AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Sat, 2005-01-15 at 15:07, Serge E. Hallyn wrote:
> > The audit control messages are sent over netlink.  Permission checks
> > are done on the process receiving the message, which may not be the
> > same as the process sending the message.  This patch switches the
> > netlink_send security hooks to calculate the effective capabilities
> > based on the sender.  Then audit_receive_msg performs capability checks
> > based on that.
> > 
> > It also introduces the CAP_AUDIT_WRITE and CAP_AUDIT_CONTROL capabilities,
> > and replaces the previous CAP_SYS_ADMIN checks in audit code with the
> > appropriate checks.
> > 
> > Please apply.
> > 
> > Changelog:
> > 	1/15/2005: Simplified dummy_netlink_send given that dummy now
> > 		keeps track of capabilities.
> > 	1/14/2005: Many fixes based on feedback from linux-audit@redhat.com
> > 		list.
> > 	1/14/2005: Removed the netlink_msg_type helper function.
> > 	1/07/2005: Swith to using CAP_AUDIT_WRITE and CAP_AUDIT_CONTROL.
> > 
> > thanks,
> > -serge
> > 
> > Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> 
> Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

Signed-off-by: Chris Wright <chrisw@osdl.org>

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
