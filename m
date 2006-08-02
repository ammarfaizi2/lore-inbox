Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWHBEVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWHBEVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWHBEVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:21:37 -0400
Received: from ns.suse.de ([195.135.220.2]:39042 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751134AbWHBEVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:21:37 -0400
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Xen-devel] Re: [PATCH 8 of 13] Add a bootparameter to reserve high linear address space for hypervisors
Date: Wed, 2 Aug 2006 06:21:22 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <0adfc39039c79e4f4121.1154462446@ezr> <p73lkq7zvu3.fsf@verdi.suse.de> <1154490840.2570.37.camel@localhost.localdomain>
In-Reply-To: <1154490840.2570.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020621.22827.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	I think you misunderstand the purpose of parse_early_param?  It is
> designed to be called directly by the arch at some point (it is
> idempotent, so the second call in init/main.c does nothing if the arch
> has called it).  ie. in i386, it replaces parse_cmdline_early().

Ah I didn't realize that. But why is there a second call in init/main.c?  
Looks like a big hack to me. Someone was too lazy to add it to all architectures?

-Andi
