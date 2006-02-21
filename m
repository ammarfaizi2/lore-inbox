Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932707AbWBUFqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbWBUFqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 00:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbWBUFqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 00:46:35 -0500
Received: from thorn.pobox.com ([208.210.124.75]:4489 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S932707AbWBUFqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 00:46:34 -0500
Date: Mon, 20 Feb 2006 23:50:39 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs-related oops during module unload (2.6.16-rc2)
Message-ID: <20060221055039.GG3293@localhost.localdomain>
References: <20060211220351.GA3293@localhost.localdomain> <20060211224526.GA25237@kroah.com> <20060212052751.GB3293@localhost.localdomain> <20060212053849.GA27587@kroah.com> <20060216215023.GA30417@kroah.com> <20060219004751.GE3293@localhost.localdomain> <20060219005716.GA5800@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219005716.GA5800@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Feb 18, 2006 at 06:47:51PM -0600, Nathan Lynch wrote:
> > Sorry for the delay.
> > 
> > Tested against 2.6.16-rc4-ish, and it seems to do the right thing --
> > modprobe -r says the module is busy while the refcnt attribute is
> > open.  The module is allowed to unload once the file is closed.
> 
> Great, thanks for trying it out and letting me know.

Sure -- do you plan to push this for 2.6.16?

The reason I ask is that the refcnt attribute is world-readable, so a
malicious or silly user can keep the file open until an unwitting
superuser unloads a module...

Far-fetched, I suppose, but I just wanted to make this scenario clear.


Nathan
