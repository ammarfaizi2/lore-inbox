Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVAMTOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVAMTOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVAMQlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:41:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34532 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261232AbVAMQl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:41:26 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: grendel@caudium.net
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113035331.GC9176@beowulf.thanes.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050113032506.GB1212@redhat.com>
	 <20050113035331.GC9176@beowulf.thanes.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105627951.4664.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 03:53, Marek Habersack wrote:
> That might be, but note one thing: not everybody runs vendor kernels (for various
> reasons). Now see what happens when the super-secret vulnerability (with
> vendor fixes) is described in an advisory. A person managing a park of machines 
> (let's say 100) with custom, non-vendor, kernels suddenly finds out that they 
> have a buggy kernel and 100 machines to upgrade while the exploit and the

Those running 2.4 non-vendor kernels are just fine because Marcelo
chooses to work with vendor-sec while Linus chooses not to. I choose to
work with vendor-sec so generally the -ac tree is also fairly prompt on
fixing things. 

Given that base 2.6 kernels are shipped by Linus with known unfixed
security holes anyone trying to use them really should be doing some
careful thinking. In truth no 2.6 released kernel is suitable for
anything but beta testing until you add a few patches anyway. 

2.6.9 for example went out with known holes and broken AX.25 (known) 
2.6.10 went out with the known holes mostly fixed but memory corrupting
bugs, AX.25 still broken and the wrong fix applied for the smb holes so
SMB doesn't work on it

I still think the 2.6 model works well because its making very good
progress and then others are doing testing and quality management on it.
Linus is doing the stuff he is good at and other people are doing the
stuff he doesn't.

That change of model changes the security model too however.

