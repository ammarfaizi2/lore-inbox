Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWG3Q0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWG3Q0O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWG3Q0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:26:13 -0400
Received: from mail.trixing.net ([87.230.125.58]:62613 "EHLO ds666.l4x.org")
	by vger.kernel.org with ESMTP id S932351AbWG3Q0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:26:13 -0400
Message-ID: <44CCDD7E.3010207@l4x.org>
Date: Sun, 30 Jul 2006 18:25:34 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Kasper Sandberg <lkml@metanurb.dk>, Matthew Garrett <mjg59@srcf.ucam.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
References: <20060730104042.GE1920@elf.ucw.cz> <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org> <20060730114722.GA26046@srcf.ucam.org> <1154264478.13635.22.camel@localhost> <20060730145305.GE23279@thunk.org>
In-Reply-To: <20060730145305.GE23279@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.3
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: Re: ipw3945 status
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on ds666.l4x.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso schrieb:
> Personally, I don't see why the requirement of an external daemon is
> really considered that evil.  We allow drivers that depend on firmware

Well the problem is more the fear that when one vendor gets this in
the tree all others will follow. And there'll be several
incompatible userspace daemons for every possible wireless card which
you need to get the system to work (think boot cd, install over wlan).

So if this is done, there should be a clearly abstracted interface
for such a daemon. I don't see what the daemon is doing more than
echo 1 4 7 8 > /sys/.../allowed_channels and a control circuit for
tx/rx power.

> loaders, don't we?  I could imagine a device that required a digitally
> signed message (using RSA) with a challenge/response protocol embedded
> inside that was necessary to configure said device, which is
> calculated in userspace and then passed down into the kernel to be
> installed into the device so that it could function.  Do we really
> want to consider that to be objectionable?

If it's done via a standard interface as the firmware loading
is, no objection.

Jan
