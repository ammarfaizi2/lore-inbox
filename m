Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUFCRKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUFCRKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUFCRKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:10:22 -0400
Received: from main.gmane.org ([80.91.224.249]:50891 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264260AbUFCRJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:09:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: [PATCH] Symlinks for building external modules
Date: Thu, 03 Jun 2004 19:09:42 +0200
Message-ID: <yw1x8yf44lgp.fsf@kth.se>
References: <200406031858.09178.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:kAFb7Z8lNcp6dG7QkQp4nM3NBKQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> writes:

> Hi Sam,
>
> modules not in the kernel source tree need to locate both the source
> tree and the object tree (O=). Currently, the /lib/modules/$(uname
> -r)/build symlink is the only reference we have; it historically
> points to the source tree from 2.4 times. The following patch
> changes this as follows (this is what we have in the current SUSE
> tree now):
>
> 	/lib/modules/$(uname -r)/source ==> source tree
> 	/lib/modules/$(uname -r)/build ==> object tree

This will break the building of all external modules until they are
updated, and break updated modules building against older kernels
unless they check the kernel version in the makefiles..  I suggest
leaving the 'build' link as is, and using a difference name for the
build directory, perhaps 'object'.  This might look confusing, so we
could have a 'source' link as well and remove the 'build' link when
most external modules have been updated.

-- 
Måns Rullgård
mru@kth.se

