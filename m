Return-Path: <linux-kernel-owner+w=401wt.eu-S932123AbXARS4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbXARS4J (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 13:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbXARS4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 13:56:09 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:26420 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123AbXARS4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 13:56:08 -0500
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21] ehca: ehca_uverbs.c: refactor ehca_mmap() for better readability
X-Message-Flag: Warning: May contain useful information
References: <200701172312.14840.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 18 Jan 2007 10:56:01 -0800
In-Reply-To: <200701172312.14840.hnguyen@linux.vnet.ibm.com> (Hoang-Nam Nguyen's message of "Wed, 17 Jan 2007 23:12:13 +0100")
Message-ID: <adavej4b1vi.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 Jan 2007 18:56:01.0584 (UTC) FILETIME=[4C2E1300:01C73B32]
Authentication-Results: sj-dkim-8; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim8002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've kind of lost the plot here.  How does this patch fit in with the
previous series of patches you posted?  Does it replace them or go on
top of them?

Can please you resend me the full series of patch that remove the use
of do_mmap(), with all cleanups and bug fixes included?  And please
roll up the fixes, I don't want one patch that adds a yield() inside a
spinlock and then a later patch to fix it -- there's no sense in
adding landmines for people potentially doing git bisect in the
future.

And also please try to split the patches so that they don't mix
together two things -- please try to make the "remove obsolete
prototypes" patch separate from the mmap fixes.

Thanks...
