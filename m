Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbUDNH1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 03:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263941AbUDNH1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 03:27:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32231 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263931AbUDNH1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 03:27:10 -0400
Date: Wed, 14 Apr 2004 08:27:09 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040414072709.GC31500@parcelfarce.linux.theplanet.co.uk>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040414064015.GA4505@in.ibm.com> <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk> <20040414071756.GB5422@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414071756.GB5422@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 12:47:56PM +0530, Maneesh Soni wrote:
> On Wed, Apr 14, 2004 at 08:02:27AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Wed, Apr 14, 2004 at 12:10:16PM +0530, Maneesh Soni wrote:
> > > I am not sure, if pinning the kobject for the life time of symlink (dentry)
> > > may result in same problems like rmmod hang which we saw in case of pinning
> > > kobject for the life time of its directory (dentry).
> > 
> > Erm...  If rmmod _ever_ waits for refcount on kobject to reach zero, it's
> > already broken.  Do you have any examples of such behaviour?
> 
> One such example is here in this bug report related to pcmica yenta socket.
> 	http://bugme.osdl.org/show_bug.cgi?id=1884
> 
> Another one is very recent in this long thread related to USB
> 	http://thread.gmane.org/gmane.linux.usb.devel/20468

USB folks have no clue on sane lifetime rules, film at 11...
