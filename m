Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWAUBjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWAUBjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWAUBjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:39:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17313 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030264AbWAUBjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:39:16 -0500
Subject: Re: Development tree, PLEASE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Loftis <mloftis@wgops.com>
Cc: Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	 <20060120155919.GA5873@stiffy.osknowledge.org>
	 <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
	 <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr>
	 <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com>
	 <20060120194331.GA8704@kroah.com>
	 <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 21 Jan 2006 01:38:46 +0000
Message-Id: <1137807527.24161.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-20 at 13:56 -0700, Michael Loftis wrote:
> and is fine once getty gets ahold of it, it's just during the initial 
> bootup phases where it's being used as the console either by the rc scripts 
> or by the kernel that seems to go wonky.  It goes out during the initial 

A bug where the serial console could get stuck on SMP IFF a kernel and a
non kernel message were output at the same time did get fixed
(yesterday) other than that I'm not aware of any problems in this area
but the maintainer may have more ideas.

Diff is tiny if you want to see if that is what you hit, although it
would be remarkable co-incidence and luck if it was ;)

> printk output, or sometimes later...exactly when seems to be a bit of a 
> random thing.  Also it either causes, or is inputting NULL's or some other 
> (consistent) garbage (CRLF? instead of CR?) on these same blades.  So you 

Never seen CR, nul reported. Would the blades happen to use rlogin to
manage this remote serial do you know ?

> I think I have more kernel bugs and can go on, but I'll just be told 
> 'upgrade to 2.6.15' which is not an option in many cases if these are 
> indeed development releases, if only 'politically', but there are often 
> real costs involved.  And with nowhere to put patches that end up in 

Its hard to maintain an old release and just merge all the fixes into it
backporting when neccessary. At the kernel summit before 2.6 this was
discussed a lot. There are a small number of groups of people who wanted
this for the long term. Said groups either maintain such trees and sell
support/services for money, or rebuild the output of the former as a
community project.

It therefore seemed reasonable that those who want it should bear the
cost, or figure out how to maintain such backports between themselves.

> maintenance releases we're forced to maintain our own private forks, and 
> likely, because of the GPL, also publish these forks and incur all the 
> costs associated with that directly, and hope they don't become 
> popular/wanted outside of the customer base they're intended for, or skirt 
> the GPL, and only allow customers access to this stuff.

The GPL is very careful about this. If you ship the sources to your
customers then you have done your duty. If your customers choose to give
it to others so be it. If the others ask you for changes then I believe
the phrase is "business opportunity". 

> whatever their version numbers are.  I'm in an odd position of working for 
> a web hosting company, *and* doing my own Linux consulting as well, and 
> maintaining some 'embedded distros' used in these specific niche 
> applications.

Embedded can be more problematic because it is harder to spread the
load, but there are communities of people who looked at things like Red
Hat Enterprise Linux and decided that they could use the code but didn't
currently need/want the training, support and services that are what
really makes it. One obvious example is Centos which is a community tree
derived from the RHEL work, rebuilt, rebranded without
support/services/etc and downloadable for free.

Alan

