Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUCYRnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbUCYRnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:43:17 -0500
Received: from mail.shareable.org ([81.29.64.88]:23953 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263444AbUCYRnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:43:15 -0500
Date: Thu, 25 Mar 2004 17:40:53 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Peter Williams <peterw@aurema.com>
Cc: Micha Feigin <michf@post.tau.ac.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040325174053.GB11236@mail.shareable.org>
References: <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com> <20040322223456.GB2549@luna.mooo.com> <405F70F6.5050605@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405F70F6.5050605@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> >Will this be USER_HZ or kernel HZ?
> >Someone earlier suggested it would be USER_HZ which would make it
> >pointless.
> 
> It has to be whatever enables user space to correctly interpret values 
> sent to user space as "ticks".  That means USER_HZ and it's not useless 
> as it enables USER_HZ to be different and/or change without breaking 
> programs that use values expressed in "ticks".

It is, however, useless for the _other_ reasons userspace needs to
know kernel HZ, including as I mentioned userspace timer granularity.

(Btw, that usage would be better as a period rather than a frequency,
so that a "tickless" kernel can report zero).

The fundamental problem is that there are two values, and both values
have programs which can usefully use them.

How hard can it be to export both?

-- Jamie






