Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265777AbUF2PMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUF2PMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 11:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUF2PMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 11:12:15 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:47014 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265777AbUF2PMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 11:12:13 -0400
Date: Tue, 29 Jun 2004 16:11:38 +0100
From: Dave Jones <davej@redhat.com>
To: fabian.frederick@skynet.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7-mm3] cpuflags reviewed
Message-ID: <20040629151138.GA27356@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, fabian.frederick@skynet.be,
	linux-kernel@vger.kernel.org
References: <200406290842.i5T8g42d030759@outmx008.isp.belgacom.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406290842.i5T8g42d030759@outmx008.isp.belgacom.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 10:42:04AM +0200, fabian.frederick@skynet.be wrote:

 > I made this one in order to display flags in a clear way (ie better than
 > cpuinfo) and display \"what we have and what we don't\"
 > related to my arch. Kernel is authoritative there and gathers all
 > info.

How is this more authorative than a userspace app ?
If a new feature flag appears that the kernel doesn't know about,
it won't get picked up. Just as it won't in a userspace app.
The difference being, someone can grab the latest version of the
app without needing to update their whole kernel.

 > Having userland maintaining such stuff would be double-work
 > double-effort (ok, it's usual :) ).Let's say procps maintains flagging as
 > well, it would require all arch updates.

Updating userspace is less impact than kernel updates.

 > All this without the fact that kernel would be able to deliver such info
 > through a syscall or something I'm not aware of...

That would be even more overkill.  The cpuid driver does everything
you need, in userspace.  It has established userspace users.
Do you expect those users to switch over to /proc/cpuflags ?
It won't happen, and adding duplicate interfaces is just pointless.

 > IOW, userland requires more feed.Feed userland pls :))))

No, it does not.  All you patch brings afaics is the need to parse
ASCII (/proc/cpuflags) vs binary (/dev/cpu/n/cpuid), and we
already have a /proc/cpuinfo for that.

		Dave

