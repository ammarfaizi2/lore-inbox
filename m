Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUFCRik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUFCRik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265603AbUFCRhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:37:36 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:9753 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265517AbUFCRdA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:33:00 -0400
Date: Thu, 3 Jun 2004 19:36:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlinks for building external modules
Message-ID: <20040603173656.GA2301@mars.ravnborg.org>
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <200406031858.09178.agruen@suse.de> <yw1x8yf44lgp.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x8yf44lgp.fsf@kth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 07:09:42PM +0200, Måns Rullgård wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> 
> > Hi Sam,
> >
> > modules not in the kernel source tree need to locate both the source
> > tree and the object tree (O=). Currently, the /lib/modules/$(uname
> > -r)/build symlink is the only reference we have; it historically
> > points to the source tree from 2.4 times. The following patch
> > changes this as follows (this is what we have in the current SUSE
> > tree now):
> >
> > 	/lib/modules/$(uname -r)/source ==> source tree
> > 	/lib/modules/$(uname -r)/build ==> object tree
> 
> This will break the building of all external modules until they are
> updated, and break updated modules building against older kernels
> unless they check the kernel version in the makefiles..  I suggest
> leaving the 'build' link as is, and using a difference name for the
> build directory, perhaps 'object'.  This might look confusing, so we
> could have a 'source' link as well and remove the 'build' link when
> most external modules have been updated.

The existing external modules are anyway broken when using separate 
directories for source and output directories. So noting lost here.
In the case where the kernel is build in the traditional way
the build and source tree will point to the same place.

So I do not see this patch breaking existing setups, but I see
external modules not being prepared for separate build and source
directories.

Patch looks good to me, and I will forward to Andrew soon.

	Sam
