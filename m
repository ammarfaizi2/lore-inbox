Return-Path: <linux-kernel-owner+w=401wt.eu-S1947354AbWLHVqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947354AbWLHVqS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947328AbWLHVqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:46:18 -0500
Received: from gw.goop.org ([64.81.55.164]:50867 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947354AbWLHVqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:46:17 -0500
Message-ID: <4579DD22.70609@goop.org>
Date: Fri, 08 Dec 2006 13:46:10 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Paul Cameron Davies <pauld@cse.unsw.EDU.AU>
CC: Andrew Morton <akpm@osdl.org>, David Singleton <dsingleton@mvista.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Lee.Schermerhorn@hp.com
Subject: Re: new procfs memory analysis feature
References: <45789124.1070207@mvista.com> <20061207143611.7a2925e2.akpm@osdl.org> <Pine.LNX.4.64.0612081716440.28861@weill.orchestra.cse.unsw.EDU.AU>
In-Reply-To: <Pine.LNX.4.64.0612081716440.28861@weill.orchestra.cse.unsw.EDU.AU>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cameron Davies wrote:
> The PTI gathers all the open coded iterators togethers into one place,
> which would be a good precursor to providing generic iterators for
> non performance critical iterations.
>
> We are completing the updating/enhancements to this PTI for the latest
> kernel, to be released just prior to LCA.  This PTI is benchmarking
> well. We also plan to release the experimental guarded page table
> (GPT) running under this PTI.

I looked at implementing linear pagetable mappings for x86 as a way of
getting rid of CONFIG_HIGHPTE, and to make pagetable manipulations
generally more efficient.  I gave up on it after a while because all the
existing pagetable accessors are not suitable for a linear pagetable,
and I didn't want to have to introduce a pile of new pagetable
interfaces.  Would the PTI interface be helpful for this?

Thanks,
    J
