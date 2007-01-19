Return-Path: <linux-kernel-owner+w=401wt.eu-S932827AbXASRwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbXASRwp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbXASRwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:52:45 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:6138 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827AbXASRwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:52:44 -0500
X-AuditID: d80ac21c-a187abb00000330a-21-45b1056c6dad 
Date: Fri, 19 Jan 2007 17:52:57 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Nadia Derbey <Nadia.Derbey@bull.net>, Franck Bui-Huu <fbuihuu@gmail.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: unable to mmap /dev/kmem
In-Reply-To: <1169227629.3055.525.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0701191743560.10013@blonde.wat.veritas.com>
References: <45AFA490.5000508@bull.net>  <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
  <45B08B17.3060807@bull.net>  <Pine.LNX.4.64.0701191539070.4009@blonde.wat.veritas.com>
  <1169225824.3055.507.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0701191704510.7577@blonde.wat.veritas.com>
 <1169227629.3055.525.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Jan 2007 17:52:43.0587 (UTC) FILETIME=[9ECF7930:01C73BF2]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Arjan van de Ven wrote:
> On Fri, 2007-01-19 at 17:12 +0000, Hugh Dickins wrote:
> > Though so long as /dev/mem support remains, /dev/kmem might as well?
> 
> they're not the same; for a long time, /dev/mem on actual memory
> returned zeros... so you couldn't use it for rootkits ;)
> (that got "fixed" a while ago)

We fixed (or "fixed") the mmap of them both, not to give zeroes on
!PageReserved pages; but read and write were never so restricted.
(Oh, I've said "never" again - expect I'll be humiliated shortly.)
Can't rootkits work as just about as easily through read & write?

Hugh
