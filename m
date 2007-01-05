Return-Path: <linux-kernel-owner+w=401wt.eu-S1030363AbXAEHaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbXAEHaq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbXAEHaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:30:46 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:57780 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030363AbXAEHap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:30:45 -0500
Date: Thu, 04 Jan 2007 23:30:39 -0800
From: Auke Kok <sofar@foo-projects.org>
Subject: Re: Multi kernel tree support on the same distro?
In-reply-to: <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
To: Steve Brueggeman <xioborg@mchsi.com>
Cc: Akula2 <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org
Message-id: <459DFE9F.9050904@foo-projects.org>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
 <459D9872.8090603@foo-projects.org>
 <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Brueggeman wrote:
> There are some difficulties with gcc versions between linux-2.4 and linux-2.6,
> but I do not recall all of the details off of the top of my head.  If I recall
> correctly, one of the issues is, linux-2.4 ?prefers? gcc-2.96, while newer
> linux-2.6 support/prefer gcc-3.? or greater.

gcc 3.4.x works great on both 2.6 and 2.4, no issues whatsoever.

> At any rate, what I've done is create a chroot environment.  I created this
> chroot directory by installing an older distribution that was created with
> linux-2.4 in mind (example, RedHat v8.2) into that at chroot directory.  The
> easiest way to do this that I'm aware of is to install the older distribution
> (minimal development, no server junk, no X junk) on another computer, then copy
> from that computer to a directory on your development computer.

it's even easier to not do that and install and compile everything in one rootfs, which 
is perfectly possible and I have done so many times. You can leave away the chroot and 
any possible security issues that you fear, allthough those are pretty much nonexistant.

The only real bottom line issue is that module-init-tools cannot load modules on a 2.4 
kernel, and modutils doesn't do that on 2.6, so you will have to switch or wrap them to 
detect the running kernel. The same goes for udev vs. devfs.

of course, setting up a qemu image or separate partition is easier, but that was not the 
question I think.

Most binary distro's won't support this, but I think all of the source distro's and more 
specific ones support it and a few handle it out of the box.


Cheers,

Auke
