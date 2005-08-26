Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVHZSPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVHZSPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVHZSPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:15:46 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:26083 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S965164AbVHZSPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:15:46 -0400
Date: Fri, 26 Aug 2005 11:11:30 -0700
From: Tony Jones <tonyj@suse.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chris Wright <chrisw@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Rework stubs in security.h
Message-ID: <20050826181130.GA2747@immunix.com>
References: <20050825012028.720597000@localhost.localdomain> <20050825012148.690615000@localhost.localdomain> <20050826173151.GA1350@immunix.com> <1125079256.8692.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125079256.8692.65.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 02:00:56PM -0400, Stephen Smalley wrote:
> 
> That makes capability part of the core kernel again, just like DAC,
> which means that you can never override a capability denial in your
> module.  We sometimes want to override the capability implementation,
> not just apply further restrictions after it.  cap_inode_setxattr and
> cap_inode_removexattr are examples; they prohibit any access to _all_

Right, the rationale behind cap_stack.c.  Good point.  I'd forgotten that.

I guess selective internal composition is the way to go.

Tony
