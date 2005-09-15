Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVIOCIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVIOCIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVIOCIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:08:47 -0400
Received: from nome.ca ([65.61.200.81]:33208 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S1030337AbVIOCIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:08:46 -0400
Date: Wed, 14 Sep 2005 19:09:36 -0700
From: Mike Bell <mike@mikebell.org>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev FAQ from the other side
Message-ID: <20050915020935.GF15017@mikebell.org>
Mail-Followup-To: Mike Bell <mike@mikebell.org>,
	Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
References: <20050915005105.GD15017@mikebell.org> <1126746518.9652.60.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126746518.9652.60.camel@phantasy>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 09:08:38PM -0400, Robert Love wrote:
> Actually, there are not many numbers in this email.

True, but two is more than zero. If they're going to do some good, I can
always make more to show exactly how much udev slows down a boot and
such. But at this point I have my doubts as to whether any benchmarks
will change people's minds.

> What modern system, though, could survive without hotplug and sysfs and
> netlink?  You need to have those components, you want those features,
> anyhow.

This is a modern system. As I took great pains to point out, that's an
actual embedded system whose .config I copied and slightly modified for
the test.

> So your comparison is unrealistic.

Not really. sysfs has a few uses now, but there are still virtually
no embedded applications of it. Hotplug is nice for things whose
hardware change, but useless for anything else (unless you need udev).
Even on my notebook I only use it for the event from my CF port.

Note that I'm not suggesting any of those features be removed from the
kernel, merely that they should count against udev's totals when the
system in question has no other use for them. And I don't see who else
is making the argument for a couple of kB apart from exactly the sort of
people who are disabling these features. There's a reason the -tiny
patchset introduced the ability to disable sysfs, it isn't always needed
and it does take up a lot of memory and bloat the kernel.

> Your user-space argument is better.  Is ndevfs not sufficient?

Nope, unfortunately. If you read my initial response I was quite
thrilled. But once I realized the limitations of ndevfs I changed my
tone. The devfs hooks are still required to provide appropriate names,
and it is these I'm most interested in saving.
