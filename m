Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWCCPY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWCCPY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWCCPY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:24:26 -0500
Received: from [198.99.130.12] ([198.99.130.12]:4249 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932100AbWCCPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:24:25 -0500
Date: Fri, 3 Mar 2006 10:25:27 -0500
From: Jeff Dike <jdike@addtoit.com>
To: roland <devzero@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is there a COW inside the kernel ?
Message-ID: <20060303152527.GA3536@ccure.user-mode-linux.org>
References: <043101c63e9c$86e9d710$0200000a@aldipc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043101c63e9c$86e9d710$0200000a@aldipc>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 09:29:02AM +0100, roland wrote:
> hello !
> 
> is there an equivalent of something like
> 
> cowloop ( http://www.atconsultancy.nl/cowloop/total.html ) or md based cow 
> device ( http://www.cl.cam.ac.uk/users/br260/doc/report.pdf ),
> 
> i.e. a feature called "Copy On Write Blockdevice" inside the current or the 
> near-future mainline kernel (besides UserModeLinux Arch)?
> can someone help out with some information ?

Miklos Szeredi announced mountlo a few days ago - this uses a UML to
export a filesystem to the host through FUSE.  It's intended to allow
non-privileged loopback mounting of normal file system images, but
presumably will export a COW block device as well.

I'm doing something similar, and using FUSE to export the entire UML
filesystem to the host.

These aren't specifically COW drivers, but they have the same effect
as long as you have a UML with your COW device mounted.

				Jeff
