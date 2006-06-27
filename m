Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWF0Njg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWF0Njg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWF0Njg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:39:36 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24705 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932234AbWF0Njf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:39:35 -0400
Message-ID: <44A13512.3010505@garzik.org>
Date: Tue, 27 Jun 2006 09:39:30 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> What I'm more interested in is basically answering the question and where 
> I hope to provoke a bit broader discussion: "What's next?"
> 
> Until recently for most developers klibc was not much more than a cool 
> idea, but now we have the first incarnation and now we have to do a 
> reality check of how it solves our problems. To say it drastically the 
> current patch set as it is does not solve a single real problem yet, it 
> only moves them from the kernel to kinit, which may be the first step but 
> where to?
> 
> So what problems are we going to solve now and how? The amount of 
> discussion so far is not exactly encouraging. If nobody cares, then there 
> don't seem to be any real problems, so why should it be merged at all? Are 
> shiny new features more important than functionality?

Well, at least for me...  at boot time we run into various limitations 
from the current kernel approach of coding purely userspace activities 
in the kernel, simply because a vehicle for implementing early-boot 
userland operations did not exist.

This klibc patchkit removes stuff that does not need to be in the 
kernel, and provides a platform for improving IP autoconfig, NFS root, 
MD/DM root setup, and various other early-boot activities.

A lot of the larger distros have been moving in this direction anyway, 
by necessity.  They have been stuffing more and more [needed] logic into 
initrd [which is often really initramfs these days], to deal with 
complex boot and root-mounting scenarios like iSCSI and multi-path.

	Jeff


