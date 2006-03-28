Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWC1Ugh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWC1Ugh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWC1Ugh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:36:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47832 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932133AbWC1Ugg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:36:36 -0500
To: prasanna@in.ibm.com
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RFC - Approaches to user-space probes
References: <20060327065447.GA25745@in.ibm.com>
	<1143445068.2886.20.camel@laptopd505.fenrus.org>
	<20060327100019.GA30427@in.ibm.com>
	<1143489794.2886.43.camel@laptopd505.fenrus.org>
	<20060328145441.GA25465@in.ibm.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 28 Mar 2006 15:35:43 -0500
In-Reply-To: <20060328145441.GA25465@in.ibm.com>
Message-ID: <y0m64lye28w.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:

> [...]
> If the executable is mmaped shared, then those mappings will get written
> back to the disk.
> Writting to the disk is not the requirement for user-space probes, it is
> just the side effect [...]

It's pretty clear that writing the dirtied pages to disk is an
*undesirable* side-effect, and should be eliminated.  (Among many
other scenarios, imagine a kernel shutting down without all the probes
being cleanly removed.  Then the executables are irretrievably
corrupted.)

- FChE
