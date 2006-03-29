Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWC2Bk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWC2Bk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 20:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWC2Bk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 20:40:56 -0500
Received: from thunk.org ([69.25.196.29]:42200 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750757AbWC2Bkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 20:40:55 -0500
Date: Tue, 28 Mar 2006 20:40:48 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
Cc: Jeff Garzik <jeff@garzik.org>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2label suggestions
Message-ID: <20060329014048.GA29971@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Jeff V. Merkey" <jmerkey@soleranetworks.com>,
	Jeff Garzik <jeff@garzik.org>,
	"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <4429AF42.1090101@soleranetworks.com> <20060328232927.GB32385@thunk.org> <4429D3E4.3060305@wolfmountaingroup.com> <4429D11F.6040000@garzik.org> <4429E050.7080008@soleranetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4429E050.7080008@soleranetworks.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 06:18:08PM -0700, Jeff V. Merkey wrote:
> Thanks for verifying it is passed through the kernel to initrd, another 
> kernel component.    It's also stored as EXT meta data
> (also in the kernel).  and retrieved from there.  And its not accessible 
> from normal user space applications (except in raw mode).

No, the contents of initrd/initramfs is not shipped as part of a
standard kernel.org kernel.  It is the responsibility of each
distribution to set up their initrd or initramfs initial boot scripts
themselves.  One could argue that it would be better if there were a
standard set of initrd scripts (and udev binaries) paired with
specific kernel.org kernels and used by all distro's, but that's not
where we are right now.

The data is most certainly accessible from normal userspace
applications.  All they have to do is link against blkid library;
indeed the kernel doesn't do any LABEL= or UUID= searching at all.  By
design, it all supposed to be done in userspace.

						- Ted
