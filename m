Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWG3ReY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWG3ReY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWG3ReY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:34:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26345 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932381AbWG3ReX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:34:23 -0400
Subject: Re: ipw3945 status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Theodore Tso <tytso@mit.edu>
Cc: Kasper Sandberg <lkml@metanurb.dk>, Matthew Garrett <mjg59@srcf.ucam.org>,
       Jan Dittmer <jdi@l4x.org>, Pavel Machek <pavel@suse.cz>,
       Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <20060730145305.GE23279@thunk.org>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org>
	 <20060730114722.GA26046@srcf.ucam.org>
	 <1154264478.13635.22.camel@localhost>  <20060730145305.GE23279@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Jul 2006 18:52:38 +0100
Message-Id: <1154281958.1615.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-07-30 am 10:53 -0400, ysgrifennodd Theodore Tso:
> Personally, I don't see why the requirement of an external daemon is
> really considered that evil.  We allow drivers that depend on firmware

An open source daemon doing the supervising seems fine. We do that for
IPv4 even (dhcpd, dhcpcd, routed, gated, zebra, ....) ;)

> loaders, don't we?  I could imagine a device that required a digitally
> signed message (using RSA) with a challenge/response protocol embedded
> inside that was necessary to configure said device, which is
> calculated in userspace and then passed down into the kernel to be
> installed into the device so that it could function.  Do we really
> want to consider that to be objectionable?

If it controls the use of the device inappropriately then yes we should.
Suppose it passes down an RSA signed message that is computed by
verifying you are running a Red Hat Enterprise Linux 4 official shipped
kernel on an approved IBM platform and things like that - that would
annoy me.

Using GPG keys to verify code matches approved code is fine. The ISDN
layer has done this for many years and if its not the signed code
version it didn't have the old silly approvals stuff (Fortunately
nowdays even politicians have realised that if you need approval for
something to stop it doing bad stuff to the phone network then bad
people can do bad stuff anyway and this is bad for national security)

I think from a vendor perspective being able to ship a source set for
such a daemon which Intel has signed as "this source meets the rules" is
great. As an end user I want the flexibility to do other stuff except
where prohibited by law (not by Intel, not by paranoid lawyers and not
by FCC lack of clarity)

I also want to violate the power and other policy rules Intel wishes to
enforce on their hardware for legal and legitimate reasons. As a radio
amateur I am permitted in law to transmit certain classes of signals in
that frequency space at higher power than in the hands of a random UK
user of license exempt technology.

Alan

