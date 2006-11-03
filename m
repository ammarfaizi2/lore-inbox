Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753529AbWKCUrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbWKCUrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWKCUrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:47:21 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:18819 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932099AbWKCUrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:47:09 -0500
Date: Fri, 3 Nov 2006 14:47:06 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       20060906182719.GB24670@sergelap.austin.ibm.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061103204706.GA31398@sergelap.austin.ibm.com>
References: <20061103175730.87f55ff8.chris@friedhoff.org> <20061103200011.GA2206@sergelap.austin.ibm.com> <1162585797.5519.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162585797.5519.175.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Fri, 2006-11-03 at 14:00 -0600, Serge E. Hallyn wrote:
> > Quoting chris friedhoff (chris@friedhoff.org):
> > > The patch applies cleanly , compiles and runs smoothly against 2.6.18.1.
> > > 
> > > I'm running slackware-current with a 2.6.18.1 kernel on an ext3
> > > filesystem.
> > > 
> > > Background why I use the patch:
> > > With 2.6.18 to create a tuntap interface CAP_NET_ADMIN is required.
> > > Qemu uses tuntap to create a tap interface as a virtual net interface.
> > > Instead now running qemu with root privileges to give it the right
> > > to create a tap interface, i granted qemu with the help of the patch and
> > > Kaigai Kohei's userspace tools the cap-net_admin capability. So qemu
> > > runs again without root privilege but has now the right to create the
> > > tap interface.
> > > 
> > > Thanks for the patch. It reduces my the need of suid-bit progs.
> > > It should be given a spin in -mm.
> > 
> > One question is, if this were to be tested in -mm, do we want to keep
> > this mutually exclusive from selinux through config, or should selinux
> > stack on top of this?
> 
> Given that SELinux already stacks with capability and you aren't using
> the security fields (last I looked), it would seem trivial to enable
> stacking with fscaps (just add a few secondary_ops calls to the SELinux
> hooks, right?).

Yup, I just wasn't sure if there would be actual objections to the idea
of enabling both at once.

I'll send out a patch - just as soon as I figure out where I left the
src to begin with :)

thanks,
-serge
