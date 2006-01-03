Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWACWxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWACWxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWACWxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:53:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:9377 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751457AbWACWxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:53:52 -0500
Date: Tue, 3 Jan 2006 22:53:50 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCHSET] thread_info annotations and fixes
Message-ID: <20060103225350.GM27946@ftp.linux.org.uk>
References: <E1EttNa-0008PA-2x@ZenIV.linux.org.uk> <1136328105.3658.2.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136328105.3658.2.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 05:41:45PM -0500, James Bottomley wrote:
> As long as this is just wrappering the existing pointers, then that's
> fine, but just in case it matters, I should point out that, at least for
> parisc, the wrappering is incomplete: we have references to the
> thread_info pointer in the task struct via our assembly glue as well (in
> just two places: the smp secondary CPU start and the _switch_to
> implementation).

You and a _lot_ of other architectures.  That's fine - nobody suggests
centrally forced changes of data structure layouts, etc.  These decisions
belong to architecture and assembler code is obviously supposed to be
aware of WTF it is doing; such annotations belong on C side of things.
