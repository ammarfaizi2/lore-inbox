Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVC2GSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVC2GSY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVC2GSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:18:23 -0500
Received: from iabervon.org ([66.92.72.58]:6151 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262444AbVC2GSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:18:17 -0500
Date: Tue, 29 Mar 2005 01:05:55 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: "L. A. Walsh" <lkml@tlinx.org>
cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a
 check after use)
In-Reply-To: <424899D7.1080407@tlinx.org>
Message-ID: <Pine.LNX.4.21.0503290041190.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, L. A. Walsh wrote:

>     However, in this case, if the author is _certain_ the
> pointer can never be NULL, than an "ASSERT(card!=NULL);" might
> be appropriate, where ASSERT is a macro that normally compiles
> in the check, but could compile to "nothing" for embedded or
> kernels that aren't being developed in.

If the kernel dereferences a NULL pointer, it produces an extensive bug
report. The automatic oops is about the most useful thing to do if a
pointer is unexpectedly NULL.

	-Daniel
*This .sig left intentionally blank*


