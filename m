Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUCCUFO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 15:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUCCUFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 15:05:14 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:6407 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261153AbUCCUFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 15:05:09 -0500
Subject: Re: [QUESTION/PROPOSAL] udev (fwd)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-hotplug-devel@vger.kernel.org, greg@kroach.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0403032023090.1319@alpha.polcom.net>
References: <Pine.LNX.4.58.0403032023090.1319@alpha.polcom.net>
Content-Type: text/plain
Message-Id: <1078344278.1113.15.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 03 Mar 2004 21:04:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 20:27, Grzegorz Kulewski wrote:

> If I understand well, currently, when kernel detects new device, it 
> creates all important files in /sys for it, excluding device file.
> 
> So, (sorry if it was asked 100000000 times...
> ... but) why when kernel detects new device or module is loaded, no device 
> file in sysfs is created? The device files in /dev would be only links to 
> these in /sys. 
> 
> This way we could stop care about major/minor numbers and leave it to sysfs...
> And it maybe could decrease the possible races related to udev because it 
> would only create or remove links to files in /sys.
> 
> Programs will be able to easily find, for what device and where located in 
> system (buses, etc.) the device file in /dev is - with readlink.
> 
> And it should make the entire process more clear.

This is more or less how Solaris works... In Solaris, /dev entries are
just symlinks to entries under the /devices tree which is much like
/sys: a tree-like structure which is composed of buses, devices et all.

This is a feature I've always liked from Solaris.

