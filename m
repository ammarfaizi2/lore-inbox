Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVKIO3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVKIO3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVKIO3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:29:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35283 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750785AbVKIO33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:29:29 -0500
Date: Wed, 9 Nov 2005 14:29:26 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/39] NLKD - early pseudo-fs
Message-ID: <20051109142926.GU7992@ftp.linux.org.uk>
References: <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F5E.76F0.0078.0@novell.com> <43720F95.76F0.0078.0@novell.com> <43720FBA.76F0.0078.0@novell.com> <43720FF6.76F0.0078.0@novell.com> <43721024.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com> <43721119.76F0.0078.0@novell.com> <43721142.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43721142.76F0.0078.0@novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 03:09:54PM +0100, Jan Beulich wrote:
> While for limited amounts of configuration information the kernel
> command line may be suitable, it isn't when it comes to significant
> amounts of configurable entities that need to be set before the full
> kernel infrastructure is available. This patch adds functionality to
> pass one or more configuration files through the initrd, but without
> requiring knowledge of the actual structure (including compression) of
> it; the file(s) is/are attached to the end of the already built
> initrd (which obviously depends on external scripts not provided
> here).

What the hell for?  We _already_ have a way to get any set of files in
a filesystem as soon as we have VFS caches set up (and until then you
can't open anything anyway).

NAK.
