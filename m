Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbULICXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbULICXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 21:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbULICXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 21:23:17 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:1490 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261436AbULICWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 21:22:55 -0500
From: Limin Gu <limin@dbear.engr.sgi.com>
Message-Id: <200412090209.iB929oh23239@dbear.engr.sgi.com>
Subject: Re: [RFC][PATCH] jobfs - new virtual filesystem for job kernel/user interface
To: chrisw@osdl.org (Chris Wright)
Date: Wed, 8 Dec 2004 18:09:49 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, limin@dbear.engr.sgi.com (Limin Gu)
In-Reply-To: <20041208171603.G469@build.pdx.osdl.net> from "Chris Wright" at Dec 08, 2004 05:16:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> * Limin Gu (limin@dbear.engr.sgi.com) wrote:
> > I am looking for your comments on the attached draft, it is the job patch 
> > for 2.6.9. I have posted job patch for older kernel before, but in this patch
> > I have replaced the /proc/job binary ioctl calls with a new small virtual 
> > filesystem (jobfs).
> 
> Limin, glad to see you got to this.

Chris,

Thanks for your detailed review, I will work through your 
comments later. I will make the code look better.

Do you have any major concern about the overall design of jobfs?
Do you find any major flaw or big no no where you read the code?
For example, using existing procfs other than creating a new virtual
filesystem. It seems that people are moving things out of /proc, not
adding more, also procfs does not provide mkdir/chown operations, 
that are the reasons I chose a custom fs over procfs.

Another question is where do we mount the jobfs. The mount point does 
not show up in the kernel code, but what are the choices, /job, 
/dev/job, or other places? Is there any guideline about this?

Thanks!

--Limin
 
