Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTJADN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 23:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTJADN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 23:13:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:7832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261881AbTJADNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 23:13:25 -0400
Date: Tue, 30 Sep 2003 20:14:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: jun.nakajima@intel.com, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata
 patch
Message-Id: <20030930201418.2a1cdeb4.akpm@osdl.org>
In-Reply-To: <20031001025128.GD32209@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCE@scsmsx402.sc.intel.com>
	<20031001025128.GD32209@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> Nakajima, Jun wrote:
> > Oh, I thought you already closed this issue and you were discussing a
> > different thing.
> > 
> > I agree. They kernel should fix up userspace for this CPU errata.
> 
> Our question is whether kernels configured specifically for non-AMD
> (e.g. Winchip or Elan kernels) must have the AMD fixup code (it is a
> few hundred bytes), refuse to boot on AMD, ignore the problem, or work
> but not fix up userspace.

Refusing to boot would be best I think.  Fixing it up anyway would be OK
too.

Ignoring the problem in kernel and/or userspace could be viewed as a
response to pilot error but as always it would be nice if, given a choice,
we can help the pilot.
