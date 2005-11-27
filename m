Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVK0PL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVK0PL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 10:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVK0PL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 10:11:58 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:56752 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751088AbVK0PL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 10:11:57 -0500
Date: Sun, 27 Nov 2005 11:56:53 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reboot through the BIOS on newer HP laptops
Message-ID: <20051127115653.GA7126@srcf.ucam.org>
References: <20051124052107.GA28070@srcf.ucam.org> <20051126203326.07b09394.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126203326.07b09394.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 08:33:26PM -0800, Andrew Morton wrote:

> But your patch will do this for all HP laptops, will it not?  Worrisome. 
> Is it not possible to identify particular models?

Yes, but there seems to be an awfully large number of affected models 
(at least the nc4200, tc4200, nx6110, nc6120, nc6220, nc6230, nc8220, 
nc8230 and nw8240) and HP and myself couldn't figure out /why/ they 
won't reboot in the normal way, so there's a fairly good chance that the 
next generation of them will have the same problem.

It's actually a bit odd. If I write some userspace code to prod the 
keyboard controller in the same way as the kernel reboot code does, the 
system reboots. If the kernel does it, it freezes at the point where it 
pokes the keyboard controller. 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
