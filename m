Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUDNVIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUDNVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:08:17 -0400
Received: from mail.shareable.org ([81.29.64.88]:52129 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261764AbUDNVHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:07:53 -0400
Date: Wed, 14 Apr 2004 22:05:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: davidm@hpl.hp.com
Cc: linux-ia64@linuxia64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
Message-ID: <20040414210538.GG12105@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414082355.GA8303@mail.shareable.org> <20040414113753.GA9413@mail.shareable.org> <16509.25006.96933.584153@napali.hpl.hp.com> <20040414184603.GA12105@mail.shareable.org> <16509.35554.807689.904871@napali.hpl.hp.com> <20040414192844.GD12105@mail.shareable.org> <16509.39308.8764.219@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16509.39308.8764.219@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> No, Alpha Linux didn't map data without execute permission.

That was true from Linux 1.1.67 (when Alpha was introduced) to 1.1.84
(when __[PS]* was introduced).  I'm not sure the Alpha target even
worked during those versions.  Since Linux 1.1.84, it has mapped pages
on the Alpha without execute permission: the _PAGE_FOE (fault on exec)
bit is set for mappings which don't have PROT_EXEC.

Btw, they used PAGE_EXECONLY in those days :)

-- Jamie
