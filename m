Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbUK2Qax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUK2Qax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbUK2Qax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:30:53 -0500
Received: from [213.146.154.40] ([213.146.154.40]:46024 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261750AbUK2Qah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:30:37 -0500
Date: Mon, 29 Nov 2004 16:27:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Adrian Bunk <bunk@stusta.de>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Subject: Re: [2.6 patch] selinux: possible cleanups
Message-ID: <20041129162701.GA6553@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>, Adrian Bunk <bunk@stusta.de>,
	James Morris <jmorris@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
References: <20041128190139.GD4390@stusta.de> <1101744496.13948.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101744496.13948.141.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 11:08:16AM -0500, Stephen Smalley wrote:
> These functions are part of an overall interface between the AVC and the
> security server designed to support dynamic security policy
> requirements, based on prior studies including some formal analysis. 
> While the example security server does not presently use anything other
> than avc_ss_reset, I'd be hesitant to completely remove the rest of the
> interface, as that will leave a far less functional interface for future
> security servers and may lead to further "optimization" of the AVC that
> will preclude support for dynamic policy requirements (or at least make
> it much harder to restore such support).

Feel free to add it whenever you need it.  So far keeping the kernel
small and allowing for the optimizations you fear seems far more important
than some vapourware.

> >   - ss/services.c: security_member_sid
> 
> There are patches under development for SELinux that make use of this
> function, including exporting the interface to userspace via selinuxfs
> and using it in-kernel for polyinstantiation.

And the ETA for those in mainline is?

