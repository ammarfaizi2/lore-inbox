Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTJGEqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 00:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTJGEqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 00:46:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:64129 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261796AbTJGEql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 00:46:41 -0400
Date: Tue, 7 Oct 2003 10:17:03 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Patrick Mochel <mochel@osdl.org>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031007044703.GB9036@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <Pine.LNX.4.44.0310061123110.985-100000@localhost.localdomain> <20031006192713.GE1788@in.ibm.com> <20031006193050.GT7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006193050.GT7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 08:30:50PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> What's more important, for leaves of the sysfs tree your overhead is also
> a loss - we don't need to pin dentry down for them even with current sysfs
> design.   And that can be done with minimal code changes and no data changes
> at all.  Your patch will have to be more attractive than that.  What's the
> expected ratio of directories to non-directories in sysfs?

Current sysfs / kobject design _require_ that dentries for the leaves to be
present all the times. There is simply no generic way to find attributes
of a kobject. As of now it uses dentry->d_fsdata to reach to the attribute.

In my system leaves are around 65% of the total.

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
