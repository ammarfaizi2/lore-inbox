Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUEMC1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUEMC1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 22:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbUEMC1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 22:27:53 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:11259 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262063AbUEMC1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 22:27:52 -0400
Subject: Re: [PATCH] Sort kallsyms in name order: kernel shrinks by 30k
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rusty@rustcorp.com.au, kaos@sgi.com, ak@muc.de
Content-Type: text/plain
Organization: 
Message-Id: <1084406710.952.489.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 May 2004 20:05:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Admittedly, anyone who sets CONFIG_KALLSYMS doesn't
> care about space, it's a fairly trivial change.
>
> Name: Sort Kallsyms for Stem Compression
> Status: Booted on 2.6.6
> Depends: Misc/kallsyms-include-aliases.patch.gz
>
> Leaving the symbols sorted by name rather than address,
> so stem compression works more effectively.  Saves a
> little over 30k here.

That's nothing these days.

How does this change stand up to benchmarking?
Start up 12345 processes or more, then do this:

time ps -eo wchan >> /dev/null
time cat /proc/*/wchan >> /dev/null

As Keith Owens says, "top can consume a complete
cpu out of 128 cpus". (not that I can verify this)


