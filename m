Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVADMW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVADMW1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 07:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVADMW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 07:22:27 -0500
Received: from one.firstfloor.org ([213.235.205.2]:22200 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261458AbVADMWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 07:22:24 -0500
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1 [failure on AMD64]
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103100725.GA17856@infradead.org>
	<200501030919.20670.jbarnes@engr.sgi.com>
	<200501040029.15623.rjw@sisk.pl>
From: Andi Kleen <ak@muc.de>
Date: Tue, 04 Jan 2005 13:22:23 +0100
In-Reply-To: <200501040029.15623.rjw@sisk.pl> (Rafael J. Wysocki's message
 of "Tue, 4 Jan 2005 00:29:15 +0100")
Message-ID: <m1mzvpwfi8.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Monday, 3 of January 2005 18:19, Jesse Barnes wrote:
>> On Monday, January 3, 2005 2:07 am, Christoph Hellwig wrote:
>> > > add-page-becoming-writable-notification.patch
>> > >   Add page becoming writable notification
>> >
>> > David, this still has the bogus address_space operation in addition to
>> > the vm_operation.  page_mkwrite only fits into the vm_operations scheme,
>> > so please remove the address_space op.  Also the code will be smaller
>> > and faster witout that indirection..
>> 
>> And apparently it's broken on NUMA.  I couldn't find 
>> generic_file_get/set_policy in my tree, which builds with CONFIG_NUMA 
>> enabled.
>
> On a dual-Opteron w/ NUMA I had to apply the Jesse's patch to compile the 
> kernel, but it does not boot.  It only prints this to the serial console:

I suspect it is fixed by Bill Irwin's patch from the 
"[bootfix] pass used_node_mask by reference .." thread. Can you test that?

-Andi
