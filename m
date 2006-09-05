Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965264AbWIESQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbWIESQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbWIESQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:16:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:23750 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965264AbWIESQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:16:48 -0400
From: Andi Kleen <ak@suse.de>
To: Kimball Murray <kimball.murray@gmail.com>
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
Date: Tue, 5 Sep 2006 20:16:37 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
In-Reply-To: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609052016.37497.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 September 2006 19:34, Kimball Murray wrote:
> Attached is a git patch that implements a feature that is used by Stratus
> fault-tolerant servers running on Intel x86_64 platforms.  It provides the
> kernel mechanism that allows a loadable module to be able to keep track of
> recently dirtied pages for the purpose of copying live, currently active
> memory, to a spare memory module.

As other people commented we normally don't merge hook only patches.

The reason for this is that with Linux being so popular
and so many people want hooks for their various addons that if there
wasn't a fairly strict policy about it then at some point the core kernel
code might contain more hooks than actual code doing something.

But I see no reason why mainline shouldn't support Stratus
systems, so if you merge the whole thing in a clean way it 
might be possible. It must be already GPL since the exports are _GPL.

Bonus points if the dirty tracking is done in a generic enough way that it 
might be useful for other kernel things too (is that possible? I know Xen etc
use it at the Hypervisor level for various stuff) 

-Andi

