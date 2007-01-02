Return-Path: <linux-kernel-owner+w=401wt.eu-S964842AbXABM3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbXABM3y (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbXABM3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:29:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:50348 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964837AbXABM3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:29:53 -0500
In-Reply-To: <1167710537.6165.28.camel@localhost.localdomain>
References: <45978CE9.7090700@flex.com> <20061231.024917.59652177.davem@davemloft.net> <20061231154103.GA7409@infradead.org> <20061231.124612.21926488.davem@davemloft.net>  <45988210.7070300@flex.com> <1167710537.6165.28.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f8739cc0d5fe2c757eae0af65b6049d9@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, David Kahn <dmk@flex.com>,
       wmb@firmworks.com, hch@infradead.org, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 13:28:52 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> IMHO, the directory entries in the filesystem
>> should be in the form "node-name@unit-address" (eg: /pci@1f,0,
>> "pci" is the node name, "@" is the separator character defined
>> by IEEE 1275, and "1f,0" is the unit-address,
>> which are always guaranteed to be unique.
>
> They should be. The problem is buggy OF implementations. For example,
> both IBM and Apple OFs have the nasty habit of having under the CPU
> nodes an "l2-cache" node with no unit-address -and- a property with the
> same name

That is perfectly valid FWIW.  Not a "best practice" or anything,
but valid nonetheless.

Device tree semantics do not fit POSIX filesystem semantics 100%,
you do need some workarounds for some edge cases yes.

>> It's
>> not possible to have two ambiguously fully qualified nodes in the OFW
>> device tree, otherwise you would never be able to select
>> a specific one by name.
>
> Well, it happens to be the case though. The code is to work around 
> that.
> A normal bug-free tree should never trigger the workarounds.

Well it's not *technically* a bug to have two device nodes with
an exact identical path in OF, but sure :-)


Segher

