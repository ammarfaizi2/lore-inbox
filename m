Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTENNv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbTENNv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:51:57 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:57787 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S262219AbTENNvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:51:51 -0400
Date: Wed, 14 May 2003 10:02:24 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
In-Reply-To: <Pine.LNX.4.44.0305141445290.12748-100000@marcellos.corky.net>
Message-ID: <Pine.LNX.4.33.0305140954170.10993-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 May 2003, Yoav Weiss wrote:

> On Wed, 14 May 2003, Ahmed Masud wrote:
>
> >
> > 3. A slightly more sophisticated timeout framework should be created with
> > the ability to enforce expiry or request expiry extensions (upto some type
> > of a system hard limit?) on a per page.
> >
>
> Why is this one needed ?
>


Well we definitely need a way to timeout keys.  The other reason is to be
able to "change your mind" about it while the key is being used.  This may
not be a useful thing for now but think of encrypted swaps on the
infamous: oopsies-i-tripped-over-a-wire-and-disconnected-network-file-system

Here we have a situation where we want to not have an expired key with
valid data hanging out there.

Or are we saying that expiration only affects encryption and that the
decryption counterpart sticks around until its reference count goes to
zero? On the surface this seems to be easier, although not sure if it
makes us miss any situation.

Cheers,

Ahmed.

