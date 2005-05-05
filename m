Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVEEQew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVEEQew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVEEQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:34:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:5784 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbVEEQes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:34:48 -0400
Date: Thu, 5 May 2005 09:34:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: bmerry@cs.uct.ac.za
Cc: linux-kernel@vger.kernel.org
Subject: Re: Holding ref to /proc/<pid> dentry prevents task being freed
Message-ID: <20050505163413.GW23013@shell0.pdx.osdl.net>
References: <20050505091131.GA4472@omnius.cs.uct.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505091131.GA4472@omnius.cs.uct.ac.za>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* bmerry@cs.uct.ac.za (bmerry@cs.uct.ac.za) wrote:
> I'm busy writing a security module that does some very basic ACL stuff
> on a per-task basis. If my module obtains and holds a dentry for
> /proc/<pid> (via path_lookup), then the task_free_security hook is
> never called for that process. Since the module releases the dentry in
> task_free_security, this creates a chicken-and-egg problem and neither
> the task nor the dentry is ever released. A side-effect is that the
> module refcount never drops to 0.

Why are you holding that dentry?  Some more background please.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
