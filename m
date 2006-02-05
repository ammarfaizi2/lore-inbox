Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWBESmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWBESmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 13:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWBESmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 13:42:04 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:41134 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751187AbWBESmD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 13:42:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RS/IpvlCnJ4Y8sbeet3AzUNdyfktqb551KXNphK0jvKXako/QtTLwXfXV9HbfOYUK+Z6DX7icSLhagm/yxI3pHUDYwXX6NqvvEqxVIzQykfm/RFWDXwnRWVcCvihwGwFgxyNwgpgeQwJU718GXy7nw8hhFzQQ2WEzynd1GZj9x8=
Message-ID: <986ed62e0602051042t11f3d81scafec9277af892e4@mail.gmail.com>
Date: Sun, 5 Feb 2006 10:42:00 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH ] VMSPLIT config options (with default config fixed)
Cc: Greg Norris <haphazard@kc.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43C53CA2.7070002@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060110132957.GA28666@elte.hu> <20060110143931.GM3389@suse.de>
	 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
	 <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de>
	 <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com>
	 <43C40803.2000106@rtr.ca>
	 <20060111160050.GA5472@yggdrasil.localdomain>
	 <43C53CA2.7070002@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Mark Lord <lkml@rtr.ca> wrote:
> Greg Norris wrote:
> > Is there any benefit/point to enabling HIGHMEM when using this patch,
> > assuming that physical memory is smaller than the address space?  For
> > example, when using VMSPLIT_3G_OPT on a box with 1G of memory.
>
> No.  In fact, there should be a (very) tiny performance gain
> by NOT enabling HIGHMEM -- things like kmap() should get simpler.

Actually, IIRC if you have an x86 CPU (or x86-64 running a 32-bit
kernel) which has a no-execute bit, to support that (i.e. to have a
more secure system) you need to use HIGHMEM64G, no matter how much or
how little RAM you have.
--
-Barry K. Nathan <barryn@pobox.com>
