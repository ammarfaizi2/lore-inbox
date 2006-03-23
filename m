Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWCWJZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWCWJZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWCWJZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:25:21 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:43234 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751434AbWCWJZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:25:19 -0500
In-Reply-To: <20060323004006.GQ15997@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421EC44.7010500@us.ibm.com> <20060323004006.GQ15997@sorel.sous-sol.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <caf37c433827769063ccb0269adbaa09@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Jyothy Reddy <jreddy@vmware.com>, Christopher Li <chrisl@vmware.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Kip Macy <kmacy@fsmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>, Anne Holler <anne@vmware.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       virtualization@lists.osdl.org, Ky Srinivasan <ksrinivasan@novell.com>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Date: Thu, 23 Mar 2006 09:25:28 +0000
To: Chris Wright <chrisw@sous-sol.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Mar 2006, at 00:40, Chris Wright wrote:

>> Would you have less trouble if the "ROM" were actually more like a
>> module?  Specifically, if it had a proper elf header and symbol table,
>> used symbols as entry points, and was a GPL interface (so that ROM's 
>> had
>> to be GPL)?  Then it's just a kernel module that's hidden in the 
>> option
>> ROM space and has a C interface.
>
> Yeah, point is the interface is normal C API, and has the similar free
> form that normal kernel API's have.

i think this sounds very sane, and an OS-specific interface shim gets 
around problems such as finding CPU-specific state -- we can get at 
smp_processor_id() just the same as the rest of the kernel, for 
example. We could extend the concept of the interface shim we already 
have -- a set of OS-specific high performance shims, plus a fallback 
OS-agnostic shim.

  -- Keir

