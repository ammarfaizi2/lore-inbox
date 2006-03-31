Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWCaLze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWCaLze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 06:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWCaLze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 06:55:34 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49578 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751330AbWCaLzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 06:55:33 -0500
Date: Fri, 31 Mar 2006 17:25:29 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RFC - Approaches to user-space probes
Message-ID: <20060331115529.GA3501@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060327065447.GA25745@in.ibm.com> <1143445068.2886.20.camel@laptopd505.fenrus.org> <20060327100019.GA30427@in.ibm.com> <1143489794.2886.43.camel@laptopd505.fenrus.org> <20060328145441.GA25465@in.ibm.com> <y0m64lye28w.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y0m64lye28w.fsf@ton.toronto.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 03:35:43PM -0500, Frank Ch. Eigler wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:
> 
> > [...]
> > If the executable is mmaped shared, then those mappings will get written
> > back to the disk.
> > Writting to the disk is not the requirement for user-space probes, it is
> > just the side effect [...]
> 
> It's pretty clear that writing the dirtied pages to disk is an
> *undesirable* side-effect, and should be eliminated.  (Among many
> other scenarios, imagine a kernel shutting down without all the probes
> being cleanly removed.  Then the executables are irretrievably
> corrupted.)

Frank,

What would the tipical situations where the text section in the
executable is mapped with 'MAP_SHARED'?
This information will help solve the problem easily.

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
