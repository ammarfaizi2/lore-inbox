Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290246AbSAXEHS>; Wed, 23 Jan 2002 23:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290247AbSAXEHJ>; Wed, 23 Jan 2002 23:07:09 -0500
Received: from holomorphy.com ([216.36.33.161]:43910 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S290246AbSAXEHB>;
	Wed, 23 Jan 2002 23:07:01 -0500
Date: Wed, 23 Jan 2002 20:04:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Can linux support ccNUMA machine now?
Message-ID: <20020123200405.D899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020123003530.60778.qmail@web13903.mail.yahoo.com> <74750000.1011782724@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <74750000.1011782724@flay>; from Martin.Bligh@us.ibm.com on Wed, Jan 23, 2002 at 02:45:24AM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone wrote:
>> How mcuh memory linux support? 64GB or more?

On Wed, Jan 23, 2002 at 02:45:24AM -0800, Martin J. Bligh wrote:
> Theoritically 64Gb on 32 bit machines, in practice
> significantly less than that (IIRC, something like
> 25-30Gb). It's not terribly efficient in using it though ;-)

With some simple calculations for various things, I predict ZONE_NORMAL
will get filled by large boot-time allocations on x86 with PAE and 64GB
of RAM. I'm not entirely sure what other sorts of pathologies arise
while these beasts still function; but without enough ZONE_NORMAL to
satisfy all the combined boot-time allocation requests, the kernel
will surely panic.

The sizes of these boot-time allocations are not entirely constant
across kernel versions, but there should be some threshhold of
memory size at which any given Linux version to date drops dead on
large memory x86 machines.

On 64-bit machines, there is obviously no such behavior, and Linux
will be able to use the full memory capacity of the system.


Cheers,
Bill

P.S.: Blame it on struct page.
