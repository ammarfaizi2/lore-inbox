Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269225AbUJTE4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbUJTE4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270213AbUJTEu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 00:50:27 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:39343 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S270219AbUJTEsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 00:48:04 -0400
X-BrightmailFiltered: true
Date: Wed, 20 Oct 2004 10:14:44 +0530
From: Ganesan R <rganesan@myrealbox.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: wes schreiner <wes@infosink.com>
Subject: Re: [linux-usb-devel] Re: Linux 2.6.x wrongly recognizes USB 2.0 DVD writer (solved)
Message-ID: <20041020044444.GA11635@cisco.com>
References: <416E7E39.4040102@myrealbox.com> <Pine.LNX.4.44L0.0410141025360.952-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0410141025360.952-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 10:26:53AM -0400, Alan Stern wrote:
> 
> On Thu, 14 Oct 2004, Ganesan R wrote:
> > 
> > I checked the kernel sources. Sure enough, 
> > drivers/usb/storage/unusual_devs.h
> > has a new entry in the 2.6 tree:
> > 
> > ========
> > /* <torsten.scherer@uni-bielefeld.de>: I don't know the name of the bridge
> >  * manufacturer, but I've got an external USB drive by the Revoltec company
> >  * that needs this. otherwise the drive is recognized as /dev/sda, but any
> >  * access to it blocks indefinitely.
> >  */
> > UNUSUAL_DEV(  0x0402, 0x5621, 0x0103, 0x0103,
> >         "Revoltec",
> >         "USB/IDE Bridge (ATA/ATAPI)",
> >         US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_FIX_INQUIRY),
> > ========
> > 
> > I have not yet tested after removing this entry, but this looks to be 
> > the likely problem. The enclosure actually supports both 3.5 IDE hard 
> > disks as well as 5.25 CD/DVD drives. I have no clue why this entry 
> > should cause the drive to be wrongly detected. CCing linux-usb-devel for 
> > help.
> 
> Certainly that entry is the problem.  It has been removed in the latest 
> development kernels; it may already be gone in 2.6.9-rc4.

I removed that entry and recompiled 2.6.8. The drive is now recognized
properly again in 2.6.8. Thanks to every one who helped.

Ganesan
