Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUCVHJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 02:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUCVHJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 02:09:20 -0500
Received: from ns.suse.de ([195.135.220.2]:13195 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261794AbUCVHJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 02:09:16 -0500
Date: Mon, 22 Mar 2004 08:09:12 +0100
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop O_LARGEFILE from F_GETFL for POSIX compliance
Message-Id: <20040322080912.1dc28fc1.ak@suse.de>
In-Reply-To: <405E900C.2070502@redhat.com>
References: <20040322051318.597ad1f9.ak@suse.de>
	<20040321213944.2fdb980d.akpm@osdl.org>
	<20040322071425.3cd57aca.ak@suse.de>
	<405E900C.2070502@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004 23:04:44 -0800
Ulrich Drepper <drepper@redhat.com> wrote:

> Andi Kleen wrote:
> 
> > No, because O_LARGEFILE is not part of POSIX :-) (they use open64 etc.)
> 
> What are you talking about?  Neither O_LARGEFILE nor open64 is in POSIX.
>  But both are in the LFS extensions.
> 
> This whole change seems dubious at best.  Who has argued that
> O_LARGEFILE mustn't be returned?  I do not agree at all.  If the test
> suite checks this the author must defend the position.

I complained to this to the Austin group people at that point
and Andrew Josey told me that the issue has been discussed and the comittee
ruled that the Linux behaviour was not compliant I didn't inquire about the details
(standardeese bores me), ask him himself.

> I suggest to not make any changes.  It is perfectly OK to define new O_
> flags and the open() specification does not require that none of them
> must set implicitly.

Just the LSB test suite won't pass then.

-Andi
