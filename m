Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423558AbWJaQ3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423558AbWJaQ3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423561AbWJaQ3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:29:11 -0500
Received: from mail.gmx.de ([213.165.64.20]:29674 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423558AbWJaQ3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:29:09 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@suse.de>
Cc: "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <20061031072241.GB7306@suse.de>
References: <45461977.3020201@shadowen.org> <45461E74.1040408@google.com>
	 <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>
	 <45463481.80601@shadowen.org>
	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	 <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com>
	 <20061031065912.GA13465@suse.de>
	 <1162278594.6416.4.camel@Homer.simpson.net> <20061031072241.GB7306@suse.de>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 17:28:46 +0100
Message-Id: <1162312126.5918.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 23:22 -0800, Greg KH wrote:
> On Tue, Oct 31, 2006 at 08:09:54AM +0100, Mike Galbraith wrote:

> > > Merely change CONFIG_SYSFS_DEPRECATED to be set to yes, and it should
> > > all work just fine.  Doesn't anyone read the Kconfig help entries for
> > > new kernel options?
> > 
> > That's terminal here atm:  kernel BUG at arch/i386/mm/pageattr.c:165!
> > 
> > I did have it set, but had to disable it to not panic.
> 
> I think there are two different issues here.  That kernel config option
> should not be causing an oops in mm code.
> 
> Can you bisect the different patches to see which one causes the
> problem?

I'm not bisecting, but I'm making progress anyway.  Definitely seems to
be one of the driver-core-* patches.  I'm applying things to 2.6.19-rc3
virgin group wise, and as soon as I applied those, wham.  

With only [1] *acpi*, gregkh-driver*, and gregkk-pci* and all was well
(except it didn't cure my eth0 woes).

Still poking at it.

	-Mike

