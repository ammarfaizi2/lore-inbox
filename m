Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWCANy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWCANy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWCANy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:54:28 -0500
Received: from gate.in-addr.de ([212.8.193.158]:12515 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932076AbWCANy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:54:28 -0500
Date: Wed, 1 Mar 2006 14:53:56 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060301135356.GC23159@marowsky-bree.de>
References: <20060227190150.GA9121@kroah.com> <p7364n01tv3.fsf@verdi.suse.de> <20060227194400.GB9991@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060227194400.GB9991@suse.de>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-02-27T11:44:00, Greg KH <gregkh@suse.de> wrote:

> > Ok, but how do you plan to address the basic practical problem?
> > People cannot freely upgrade/downgrade kernels anymore since udev/hal
> > are used widely in distributions.
> I can freely upgrade/downgrade kernels on some distros[1] if I wish to,
> as they support such things.  Just complain to your distro maker if you
> have this issue :)

This is a somewhat cheap excuse.

The fact is that now we have user-space and kernel space tied together
much more intimately than ever; udev & sysfs being the prime examples
these days, and then it's not that some figure in top is wrong, but
"oops my network no longer loads and the box is 400 miles away".

I don't have any issue with that per se, and the kernel can continue to
change as much as it wants, but for the users' sake, the user-land needs
to be at least _backwards compatible_ for a number of kernel releases.

ie, you can upgrade the kernel, and this forces you to upgrade the
user-space - annoying, but alright -, but at least said user-space will
support the older kernel(s) in case one has to go back (or accidentially
doesn't boot into the new kernel at all ;-).

So that a user could always be sure that if they are running udev-latest
(for example; a number of other projects have the same issue), they can
run almost any kernel up to that point.

This isn't a policy we can dictate to user-space, but an expectation it
should measure up to, at least for such critical components as required
for the system to get up to the point of being able to log in
(serial/console/ssh) again and fix anything.

Interfaces in the boot path are more critical than sound or even gfx
starting up or not, which is merely annoying ;-)


That said, the proposal is great, as are Ted's comments. We definetely
need to document which parts of the evolving interface are supposed to
be stable, otherwise we're confusing the users mightily and causing much
havoc. And users can also use this as evidence against us ("you said
the interface was _stable_, damn it!" and we'd have to at least go
"Oops, sorry, we had to." instead of "neener neener!" ;-) Please go
ahead with this!


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

