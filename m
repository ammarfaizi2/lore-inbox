Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbUC2XCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUC2XCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:02:34 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:19144 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S263180AbUC2XC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:02:29 -0500
Subject: Re: older kernels + new glibc?
From: David T Hollis <dhollis@davehollis.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <D8E351AF-81C8-11D8-A0A8-000A959DCC8C@sonous.com>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
	 <1080594005.3570.12.camel@laptop.fenrus.com>
	 <50DC82B4-81C5-11D8-A0A8-000A959DCC8C@sonous.com>
	 <1080595343.3570.15.camel@laptop.fenrus.com>
	 <ACFAE876-81C7-11D8-A0A8-000A959DCC8C@sonous.com>
	 <20040329212832.GB26854@devserv.devel.redhat.com>
	 <D8E351AF-81C8-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Type: text/plain
Message-Id: <1080601405.3064.3.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 (1.5.5-1) 
Date: Mon, 29 Mar 2004 18:03:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 13:34 -0800, Lev Lvovsky wrote:

> On Mar 29, 2004, at 1:28 PM, Arjan van de Ven wrote:
> >> perfect - where does this variable get set?  sorry for what now seems
> >> like OT glibc stuff.
> >
> > it's passed to glibc ./configure at build time; if you have an rpm 
> > based
> > distro you'll see it in the specfile of the src.rpm
> 
> ok, so this presents a bit of a problem in that case (assuming I'm 
> understanding you) - I'm working backwards in this respect, as I'm 
> using the "new" version of glibc, and an older version of the kernel 
> than the one that glibc was told to remain compatible with - the 
> important question, is does this order of operations (possibly) break 
> things, or does the fact that I compiled the kernel on this new version 
> of glibc remove any issues.
> 
> thanks,
> -lev
> 
> -
In looking at the latest and greatest glibc spec file for Fedora, it
appears that on x86 architectures, glibc is built to support all the way
down to 2.2.5.  On 64 bit arches, its set for various 2.4 kernels.  If
you are using Red Hat or Fedora, you will probably be ok.  Any other
distro and I can't help you there.  If it is just these drivers that are
holding you to 2.2, you can certainly find folks willing to port them to
2.4 or 2.6 for a reasonable fee that is quite certainly less than the
amount of man hours you will spend trying to get this house of cards
together.  Depending on what the drivers do and how they are written, it
may be trivial or it may be quite involved.


-- 
David T Hollis <dhollis@davehollis.com>

