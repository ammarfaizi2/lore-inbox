Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUDIUnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 16:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbUDIUnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 16:43:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:49042 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261745AbUDIUn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 16:43:29 -0400
Date: Fri, 9 Apr 2004 13:43:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org, sds@epoch.ncsc.mil
Subject: Re: [PATCH, local root on 2.4, 2.6?] compute_creds race
Message-ID: <20040409134323.L22989@build.pdx.osdl.net>
References: <4076F02E.1000809@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4076F02E.1000809@myrealbox.com>; from luto@myrealbox.com on Fri, Apr 09, 2004 at 11:49:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> The setuid program is now running with uid=euid=500 but full permitted 
> capabilities.

Yes, dropping and regaining the lock is asking for trouble.  Thank you for
catching this.  I don't have an issue with changing the interface name.
I guess the only question I have is if it's better to leave the setuid
handling in the core, and move the newly named hook under the task_lock()?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
