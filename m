Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbTBXVim>; Mon, 24 Feb 2003 16:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTBXVim>; Mon, 24 Feb 2003 16:38:42 -0500
Received: from mail.somanetworks.com ([216.126.67.42]:2012 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S267545AbTBXVik>; Mon, 24 Feb 2003 16:38:40 -0500
Date: Mon, 24 Feb 2003 16:48:49 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Greg KH <greg@kroah.com>
cc: Rusty Lynch <rusty@linux.co.intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: CPCI stopped building
In-Reply-To: <20030224204457.GA3463@kroah.com>
Message-ID: <Pine.LNX.4.44.0302241643320.25661-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Greg KH wrote:

> On Mon, Feb 24, 2003 at 12:21:44PM -0800, Rusty Lynch wrote:
> > Attempting to turn on cpci support on the latest kernel breaks the build.
> > The problem is that pci_is_dev_in_use() has been removed, but 
> > cpci_hotplug_pci.c still calls the non-existant function in 
> > unconfigure_visit_pci_dev_phase1().
> > 
> > It looks like pci_dev_driver(dev) can be used in replacement (since that is
> > what driver/pci/hotplug.c is now doing in pci_remove_device_safe(), but 
> > I haven't taken the time to really understand what is happening.
> 
> Yes, Christoph sent me this patch a few days ago, and I noticed it just
> got into the the tree.  I'm makeing a lot of pci hotplug core and driver
> cleanups right now, and will handle this one too.

That's great, thanks.  As I mentioned previously on pcihpd-discuss, I've 
got a couple of small cPCI fixes that I'll re-diff and post after what's 
in your patch queue has landed.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

