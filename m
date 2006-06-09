Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWFISpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWFISpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWFISpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:45:52 -0400
Received: from hera.kernel.org ([140.211.167.34]:14757 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030375AbWFISpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:45:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc
Date: Fri, 9 Jun 2006 11:45:24 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6cfk4$aa9$1@terminus.zytor.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <bda6d13a0606062351i5c94414fpa03ee2ce3dd180ae@mail.gmail.com> <e67fg0$grr$1@terminus.zytor.com> <8764ja7o2d.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149878724 10570 127.0.0.1 (9 Jun 2006 18:45:24 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 9 Jun 2006 18:45:24 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <8764ja7o2d.fsf@hades.wkstn.nix>
By author:    Nix <nix@esperi.org.uk>
In newsgroup: linux.dev.kernel
> > 
> > You shouldn't pivot_root the rootfs filesystem.
> 
> What happens if you do? I mean, it doesn't make even conceptual sense,
> really. The rootfs is always there: that's its entire purpose.
> 

"What happens if you do"... well, it may work, it might not, it may
break some functionality for you or break in a future kernel version.
It's undefined behaviour.

> >                                                 Use the run-init
> > utility or something similar instead (which does a mount with
> > MS_MOVE.)
> 
> busybox has a switch_root tool which (conceptually) rm -rf's everything
> on the root filesystem and then does such a mount. (After all whatever
> is on that filesystem is inaccessible after the overmount, so keeping
> it around is just a waste of memory.)

What busybox calls switch_root is the same as the run-init tool from
the klibc distribution.

	-hpa
