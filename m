Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUHUWIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUHUWIy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 18:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267965AbUHUWIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 18:08:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55979 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267955AbUHUWIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 18:08:15 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] improve OProfile on many-way systems
Date: Sat, 21 Aug 2004 18:06:31 -0400
User-Agent: KMail/1.6.2
Cc: John Levon <levon@movementarian.org>, oprofile-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, anton@samba.org, phil.el@wanadoo.fr
References: <20040821192630.GA9501@compsoc.man.ac.uk> <20040821135833.6b1774a8.akpm@osdl.org>
In-Reply-To: <20040821135833.6b1774a8.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408211806.32566.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 21, 2004 4:58 pm, Andrew Morton wrote:
> John Levon <levon@movementarian.org> wrote:
> > Anton prompted me to get this patch merged.  It changes the core buffer
> >  sync algorithm of OProfile to avoid global locks wherever possible.
> >  Anton tested an earlier version of this patch with some success. I've
> >  lightly tested this applied against 2.6.8.1-mm3 on my two-way machine.
>
> OK.  Oprofile isn't the most commonly tested part of the kernel.  Given
> that you've "lightly tested" it, how do we know when it has had sufficient
> testing for its swim upstream?

I'll give it a go on Monday, when I have some more time reserved on the 512p 
system.  Last time I tried enabling oprofile, the system wouldn't boot or at 
least got so slow that I didn't want to wait for it (i.e. init started, but 
the system pretty much hung part way through the init scripts).

If it boots, I'll try collecting some info.  John, will the oprofile tools in 
RHEL3 work with 2.6.8.1-mm3 + these patches?

Thanks,
Jesse
