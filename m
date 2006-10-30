Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbWJ3QsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbWJ3QsL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWJ3QsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:48:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965257AbWJ3QsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:48:09 -0500
Date: Mon, 30 Oct 2006 08:47:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-Id: <20061030084722.ea834a08.akpm@osdl.org>
In-Reply-To: <45461E74.1040408@google.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<45461977.3020201@shadowen.org>
	<45461E74.1040408@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 07:47:00 -0800
"Martin J. Bligh" <mbligh@google.com> wrote:

> Andy Whitcroft wrote:
> > Andrew Morton wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc3/2.6.19-rc3-mm1/
> >>
> >> - ia64 doesn't compile due to improvements in acpi.  I already fixed a huge
> >>   string of build errors due to this and it's someone else's turn.
> >>
> >> - For some reason Greg has resurrected the patches which detect whether
> >>   you're using old versions of udev and if so, punish you for it.
> >>
> >>   If weird stuff happens, try upgrading udev.
> > 
> > I have four machines showing problems with 2.6.19-rc3-mm1.  In each case
> > they appear to have lost their ethernet cards completely.  I have a
> > ppc64 using ibm_veth, two ppc64's using e1000's and an x86_64 using a
> > Tigon 3.
> > 
> > Before I had results from the non e1000 machines I did try backing out
> > all e1000 patches to no effect.  I also had a quick scan of the
> > changelogs for net/ and nothing jumped out at me.
> > 
> > Any suggestions what to hack out next?
> 
> At least on one machine with 8 tg3 cards, it finds all its interfaces,
> but then drops into:
> 
> 
> 
> Setting up network interfaces:
>       lo
>      lo        IP address: 127.0.0.1/8
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0
>                No configuration found for eth0
> 7[?25l[1A[80C[10D[1munused[m8[?25h    eth1
>              No configuration found for eth1
> 
> for all 8 cards.

What version of udev is being used?

Was CONFIG_SYSFS_DEPRECATED set?
