Return-Path: <linux-kernel-owner+w=401wt.eu-S932763AbWLTA6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWLTA6e (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWLTA6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:58:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52352 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932763AbWLTA6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:58:33 -0500
Date: Tue, 19 Dec 2006 19:58:22 -0500
From: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [PATCH 0/4] New firewire stack - updated patches
Message-ID: <20061220005822.GB11746@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a new set of patches for the new firewire stack.  The changes
since the last set of patches address the issues that were raised on
the list and can be reviewed in detail here:

  http://gitweb.freedesktop.org/?p=users/krh/juju.git

but to sum up the changes:

 - Got rid of bitfields.

 - Tested on ppc, ppc64 x86-64 and x86.

 - ioctl interface tested on 32-bit userspace / 64-bit kernels.

 - ASCIIfied sources.

 - Incorporated Jeff Garziks comments.

 - Updated to work with the new workqueue API changes.

 - Moved subsystem to drivers/firewire from drivers/fw.

plus a number of bug fixes.

As mentioned last time, the stack still lacks isochronous receive
functionality to be on par with the old stack, feature-wise.  This is
the one remaining piece of feature work kernel-side.  When that is
done, I have a couple of TODO items in user space:

 - Make a libraw1394 compatibility library

 - Port libdv1394 to new isochronous API.

which will allow us to move most user space applications to the new
stack.  That is, even if the new stack provides a new interface for
asynchronous and isochronous IO, a lot of applications can still work
since the changes are isolated to a couple of libraries.  This is
still in development and is being discussed on the linux1394-devel
list.  It will likely require a few changes kernel side in the stack
as we figure out how to do this.

It is still work in progress, but at least now it should work across
all architectures and endianesses.

Happy Holidays,
Kristian

