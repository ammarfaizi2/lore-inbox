Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbREOXgC>; Tue, 15 May 2001 19:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbREOXfx>; Tue, 15 May 2001 19:35:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16299 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261706AbREOXfn>;
	Tue, 15 May 2001 19:35:43 -0400
Date: Tue, 15 May 2001 19:35:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: David Brownell <david-b@pacbell.net>
cc: mjfrazer@somanetworks.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <047801c0dd95$231331e0$6800000a@brownell.org>
Message-ID: <Pine.GSO.4.21.0105151927480.22958-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, David Brownell wrote:

> I suppose that for network interface names, some convention for
> interface ioctls would suffice to solve that "identify" step.  PCI
> devices would return the slot_name, USB devices need something
> like a patch I posted to linux-usb-devel a few months back.

This is crap. For user tools (_especially_ for admin scripts) ioctls
are damn inconvenient. I don't have Perl or Python on the root fs.
And I don't need yet another binary lurking in /sbin, thank you
very much.

If you want to do it - do it right. Accessing /dev/eth/<n>/MAC
is trivial. Wanking with ioctls is not. And populating such tree
is as simple as it gets.

