Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTBEQkZ>; Wed, 5 Feb 2003 11:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTBEQkZ>; Wed, 5 Feb 2003 11:40:25 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:22795 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261689AbTBEQkX>; Wed, 5 Feb 2003 11:40:23 -0500
Date: Wed, 5 Feb 2003 16:49:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: greg@kroah.com, torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030205164948.A22628@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
	torvalds@transmeta.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <200302051647.LAA05940@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302051647.LAA05940@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Feb 05, 2003 at 11:47:05AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 11:47:05AM -0500, Stephen D. Smalley wrote:
> a classic kernel object (ctl_table) x operation interface, with the
> subject implicitly passed via current, just like permission() for
> inodes.  A security module can leave the hook unimplemented (no
> restrictions beyond DAC), or implement a purely process-based
> restriction or implement fine-grained controls to individual sysctls.
> Sysctls are already exposed to userspace via sysctl(2) and/or
> /proc/sys, so I'm not sure what the concern is there.  Nothing
> complicated here.

The wrong thing here is that you pass in the object itself, not
it's ACC-relevant attributes.

> 
> As to your argument about LSM's flexibility, LSM simply followed the
> guidance on what would be accepted into 2.5.  The original
> SELinux/Flask architecture was more tightly integrated and had
> well-defined boundaries while still providing substantial flexibility,
> but the response to the SELinux presentation was to move towards
> something more like LSM.  Seems pointless to argue about it now, except
> as suggestions for future directions for LSM in 2.7.

No it seems not pointless.  You add tons of undesigned cruft to 2.5 that
will have to be maintained through all of 2.6. unless Linus hopefully
pulls the plug soon enough.  You still haven't even submitted a single
example that actually uses LSM into mainline.

Yes, I'm pissed that we get this crap all over the place, making code
harder to follow and that without any actual benefit to the mainline tree.

Please come up with something better for 2.7 and leave 2.5 alone, this will
help anyone.

