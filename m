Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVARNiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVARNiC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 08:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVARNiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 08:38:02 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:51882 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261285AbVARNhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 08:37:42 -0500
Subject: Re: [PATCH] Fix audit control message checks
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <hallyn@cs.wm.edu>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050115200734.GA22087@escher.cs.wm.edu>
References: <20050115200734.GA22087@escher.cs.wm.edu>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1106055058.18274.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 18 Jan 2005 08:30:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 15:07, Serge E. Hallyn wrote:
> The audit control messages are sent over netlink.  Permission checks
> are done on the process receiving the message, which may not be the
> same as the process sending the message.  This patch switches the
> netlink_send security hooks to calculate the effective capabilities
> based on the sender.  Then audit_receive_msg performs capability checks
> based on that.
> 
> It also introduces the CAP_AUDIT_WRITE and CAP_AUDIT_CONTROL capabilities,
> and replaces the previous CAP_SYS_ADMIN checks in audit code with the
> appropriate checks.
> 
> Please apply.
> 
> Changelog:
> 	1/15/2005: Simplified dummy_netlink_send given that dummy now
> 		keeps track of capabilities.
> 	1/14/2005: Many fixes based on feedback from linux-audit@redhat.com
> 		list.
> 	1/14/2005: Removed the netlink_msg_type helper function.
> 	1/07/2005: Swith to using CAP_AUDIT_WRITE and CAP_AUDIT_CONTROL.
> 
> thanks,
> -serge
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

