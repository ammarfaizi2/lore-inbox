Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbVKOOmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbVKOOmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVKOOmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:42:45 -0500
Received: from cantor.suse.de ([195.135.220.2]:3730 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751433AbVKOOmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:42:45 -0500
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] HOWTO do Linux kernel development
References: <20051114220709.GA5234@kroah.com>
From: Andi Kleen <ak@suse.de>
Date: 15 Nov 2005 15:42:44 +0100
In-Reply-To: <20051114220709.GA5234@kroah.com>
Message-ID: <p73veyu2crf.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> writes:

> The kernel is written using GNU C and the GNU toolchain. While it
> adheres to the ISO C99 (??) standard, it uses a number of extensions

C89 - The few left over gcc 2.95 users are blocking modern C constructs.
Even without that it would be a C99 subset, e.g. arbitary long long divisions 
or floating point are not supported.

Also the kernel is a freestanding C environment, so parts are not supported.

> Also realize that it is not acceptable to send patches for inclusion
> that are unfinished and will be "fixed up later."

I'm not sure I fully agree on that. I conflicts with the "merge early, merge
often" imperative.  IMHO it's ok to submit patches that are not perfect,
but improve something or make a incremental cleanup step, as long as the
problems are not severe and the patch by itself is a clear improvement. Of course
this is handled on a case by case basis.

> 
> Justify your change
> -------------------
> 
> Along with breaking up your patches, it is very important for you to let
> the Linux community know why they should add this change.  New features
> must be justified as being needed and useful.

My request is that each patch should carry a meaningful changelog.
That should tell why and a rough (doesn't need to be detailed) overview how
the change is done.

-Andi
