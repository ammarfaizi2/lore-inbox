Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUJMBWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUJMBWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUJMBWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:22:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47019 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268180AbUJMBWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:22:12 -0400
Date: Tue, 12 Oct 2004 20:22:06 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041013012206.GA368@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com> <416C5C26.9020403@redhat.com> <20041013005856.GA3364@IBM-BWN8ZTBWA01.austin.ibm.com> <416C8048.1000602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416C8048.1000602@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 06:09:28PM -0700, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Serge E. Hallyn wrote:
> 
> >>  selinux: user_u:user_r:user_t
> > 
> > 
> > This is exactly what my current stacker does, to the byte  :-)
> 
> This is all nice and good, but you have to bring this up with the
> SELinux people _now_ since, as I said before, the current
> SELinux-enabled userland code might not even start with this change of
> the format even if SELinux is not enabled.  If it is decided that
> /proc/*/attr/current does not belong to SELinux alone, then the guys
> should be told about it now so that all the relevant code (libselinux,
> kernel without your "stacker" stuff, ...) can be changed before the
> current use spreads too far.

Then they would have to check for an optional "selinux: " at the front
of each security_setprocattr entry read in the kernel, in order to handle
an lsm infrastructure change which might never be accepted into the kernel
anyway.  I suppose it's pretty trivial anyway, but then why would they
bother...

-serge
