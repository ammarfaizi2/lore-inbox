Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUINWxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUINWxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUINWwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:52:35 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:51402 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267634AbUINWsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:48:33 -0400
Date: Wed, 15 Sep 2004 00:47:31 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Greg KH <greg@kroah.com>
Cc: "Marco d'Itri" <md@Linux.IT>, "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040914224731.GF3365@dualathlon.random>
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914215122.GA22782@kroah.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 02:51:22PM -0700, Greg KH wrote:
> True, so sit and spin and sleep until you see the device node.  That's
> how a number of distros have fixed the fsck startup issue.

that's more a band-aid than a fix (I can imagine a userspace hang if the
device isn't created for whatever reason), if there's no way to do
better than this if you've to run fsck (or if it's not the best to run
the fsck inside the dev.d scripts), then probably this needs better
fixing. is such a big problem to execute a sys_wait4 to wait the udev
userspace to return before returning from the insmod syscall?
