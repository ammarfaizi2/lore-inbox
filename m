Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVDEJUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVDEJUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVDEJUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:20:52 -0400
Received: from ozlabs.org ([203.10.76.45]:7069 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261650AbVDEJUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:20:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16978.22617.338768.775203@cargo.ozlabs.ibm.com>
Date: Tue, 5 Apr 2005 19:20:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
In-Reply-To: <21d7e99705040502073dfa5e5@mail.gmail.com>
References: <20050405000524.592fc125.akpm@osdl.org>
	<20050405074405.GE26208@infradead.org>
	<21d7e99705040502073dfa5e5@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie writes:

> Paulus these look like your patches care to update them with the "new"
> method of doing stuff..

What are we going to do about the DRM CVS?  Change it to the new way
and break everyone running 2.6.10 or earlier, or leave it at the old
way that will work for people with distro kernels, and have a
divergence between it and what's in the kernel?

Also, the compat_ioctl method is called without the BKL held, unlike
the ioctl method.  What impact will that have?  Do we need to take the
BKL in the compat_ioctl method?

Paul.
