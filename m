Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbULVCe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbULVCe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 21:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbULVCe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 21:34:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:37114 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261865AbULVCe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 21:34:57 -0500
Subject: Re: /sys/block vs. /sys/class/block
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <1103612870.21771.22.camel@gaston>
References: <1103526532.5320.33.camel@gaston>
	 <20041220224950.GA21317@kroah.com>  <1103612870.21771.22.camel@gaston>
Content-Type: text/plain
Message-Id: <1103682804.3926.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Dec 2004 18:34:39 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 23:07, Benjamin Herrenschmidt wrote:
> On Mon, 2004-12-20 at 14:49 -0800, Greg KH wrote:
> > On Mon, Dec 20, 2004 at 08:08:52AM +0100, Benjamin Herrenschmidt wrote:
> > > I'm trying to understand why we have /sys/block instead
> > > of /sys/class/block, and so far, I haven't found a single good argument
> > > justifying it... It just messes up the so far logical layout of sysfs
> > > for no apparent reason.
> > 
> > Because /sys/block happened before /sys/class did.  Al Viro converted
> > the block layer before I got the struct class stuff working properly
> > during 2.5.
> > 
> > And yes, I would like to convert the block layer to use the class stuff,
> > but for right now, I can't as class devices don't allow
> > sub-classes-devices, and getting to that work is _way_ down on my list
> > of things to do.
> 
> but can't we at least artificially move it down to /sys/class anyway for
> the sake of a sane userland API ?


Just as a note, libsysfs treats /sys/block as a class, as if under
/sys/class. We felt that's where it belonged and that's where it will
end up.... eventually.

Thanks,

Dan

