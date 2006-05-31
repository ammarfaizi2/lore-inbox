Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWEaPtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWEaPtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 11:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWEaPtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 11:49:49 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:17332 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965069AbWEaPts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 11:49:48 -0400
Date: Wed, 31 May 2006 11:49:44 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Arjan van de Ven <arjan@linux.intel.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] selinux:  fix sb_lock/sb_security_lock nesting (Was:
 Re: 2.6.17-rc5-mm1)
In-Reply-To: <1149087412.524.169.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0605311149180.4964@d.namei>
References: <20060530022925.8a67b613.akpm@osdl.org> 
 <6bffcb0e0605301139l2b4895d0mbecffb422fb2c0cf@mail.gmail.com> 
 <1149015890.3636.92.camel@laptopd505.fenrus.org>
 <1149087412.524.169.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006, Stephen Smalley wrote:

> Yes, looks that way, although oddly I don't see this warning myself upon
> performing a umount (w/ 2.6.17-rc5-mm1-lockdep).  Patch below should
> fix.
> 
> ---
> 
> Fix unsafe nesting of sb_lock inside sb_security_lock in selinux_complete_init.
> Detected by the kernel locking validator.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>
