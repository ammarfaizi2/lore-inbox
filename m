Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVADVMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVADVMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVADVKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:10:03 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:15536 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261841AbVADVFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:05:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.10-mm1 [failure on AMD64]
Date: Tue, 4 Jan 2005 22:05:48 +0100
User-Agent: KMail/1.7.1
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org> <200501040029.15623.rjw@sisk.pl> <m1mzvpwfi8.fsf@muc.de>
In-Reply-To: <m1mzvpwfi8.fsf@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501042205.49302.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 4 of January 2005 13:22, Andi Kleen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Monday, 3 of January 2005 18:19, Jesse Barnes wrote:
> >> On Monday, January 3, 2005 2:07 am, Christoph Hellwig wrote:
> >> > > add-page-becoming-writable-notification.patch
> >> > >   Add page becoming writable notification
> >> >
> >> > David, this still has the bogus address_space operation in addition to
> >> > the vm_operation.  page_mkwrite only fits into the vm_operations 
scheme,
> >> > so please remove the address_space op.  Also the code will be smaller
> >> > and faster witout that indirection..
> >> 
> >> And apparently it's broken on NUMA.  I couldn't find 
> >> generic_file_get/set_policy in my tree, which builds with CONFIG_NUMA 
> >> enabled.
> >
> > On a dual-Opteron w/ NUMA I had to apply the Jesse's patch to compile the 
> > kernel, but it does not boot.  It only prints this to the serial console:
> 
> I suspect it is fixed by Bill Irwin's patch from the 
> "[bootfix] pass used_node_mask by reference .." thread. Can you test that?

Sure.  It fixes the problem.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
