Return-Path: <linux-kernel-owner+w=401wt.eu-S933136AbWLaLyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933136AbWLaLyP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 06:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933138AbWLaLyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 06:54:14 -0500
Received: from flex.com ([206.126.0.13]:50371 "EHLO flex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933136AbWLaLyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 06:54:14 -0500
Message-ID: <4597A4A2.9060304@flex.com>
Date: Sun, 31 Dec 2006 03:53:06 -0800
From: David Kahn <dmk@flex.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: wmb@firmworks.com, devel@laptop.org, linux-kernel@vger.kernel.org,
       jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
References: <20061230.211941.74748799.davem@davemloft.net>	<459784AD.1010308@firmworks.com>	<45978CE9.7090700@flex.com> <20061231.024917.59652177.davem@davemloft.net>
In-Reply-To: <20061231.024917.59652177.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Miller wrote:
> From: David Kahn <dmk@flex.com>
> Date: Sun, 31 Dec 2006 02:11:53 -0800
> 
>> All we've done is created a trivial implementation for exporting
>> the device tree to userland that isn't burdened by the powerpc
>> and sparc legacy code that's in there now.
> 
> So now we'll have _3_ different implementations of exporting
> the OFW device tree via procfs.  Your's, the proc_devtree
> of powerpc, and sparc's /proc/openprom

I would not exactly call what we have for powerpc
"exporting the OFW device tree". I don't quite know
what it is, but it isn't as simple as exporting the
OFW device tree. I don't think we really wanted to
get into any of that here.

> If you want to do something new that consolidates everything, with the
> goal of deprecating the existing stuff, that's great!  But with they
> way you're doing this, all the sparc and powerpc implementations
> really can't take advantage of it.

Sure they can take advantage of it, if what they need
to export is a read-only copy of the actual device tree
without any legacy burden or having a writable/changeable
copy of it with a trivial implementation. But that's not
up to us, and that's not what's been done for powerpc and
sparc.

This is a trivial implementation that suits it's purpose.
It's simple. I'm not sure what more is needed for this
project when it's pretty clear that i386 will never need
any additional support for open firmware.

-David


