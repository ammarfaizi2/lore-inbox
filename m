Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbUACPLF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 10:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUACPLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 10:11:05 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:4874 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263468AbUACPLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 10:11:03 -0500
Date: Sat, 3 Jan 2004 16:22:41 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040103152241.GA5531@hh.idb.hist.no>
References: <20031231002942.GB2875@kroah.com> <20040101011855.GA13628@hh.idb.hist.no> <20040103055938.GD5306@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103055938.GD5306@kroah.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 09:59:38PM -0800, Greg KH wrote:
> On Thu, Jan 01, 2004 at 02:18:55AM +0100, Helge Hafting wrote:
> > On Tue, Dec 30, 2003 at 04:29:42PM -0800, Greg KH wrote:
> > > 
> > >  2) We are (well, were) running out of major and minor numbers for
> > >     devices.
> > 
> > devfs tried to fix this one by _getting rid_ of those numbers.
> > Seriously - what are they needed for?  
> 
> But devfs failed in this.  The devfs kernel interface still requires a
> major/minor number to create device nodes.
> 
Yes.  The numbers went unused in the common case of opening a device by name though.

> Hopefully I can work on fixing this up in 2.7.

Interesting - how do you plan to do this?  
There must be some connection from device node to driver.  Devfs had
a pointer in the inode.  The old way has numbers, and spend time on
a search.  

Are you considering a sort of "minimal devfs" managed by udev?

Helge Hafting
