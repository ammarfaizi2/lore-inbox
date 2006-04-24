Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWDXNki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWDXNki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDXNki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:40:38 -0400
Received: from [212.33.180.4] ([212.33.180.4]:48652 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750796AbWDXNkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:40:37 -0400
From: Al Boldi <a1426z@gawab.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
Date: Mon, 24 Apr 2006 16:37:56 +0300
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>
References: <200511142327.18510.a1426z@gawab.com> <200604241412.13267.a1426z@gawab.com> <444CB588.6090105@yahoo.com.au>
In-Reply-To: <444CB588.6090105@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604241637.56637.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Al Boldi wrote:
> > Could do that by:
> >
> > 	# echo 1 > /proc/sys/kernel/su-pid
> >
> > which would imply nr-threads = 1
> >
> > So maybe introduce /proc/sys/kernel/nr-threads to allow that to be
> > variable, but this isn't really critical.
>
> Why not just have su-nr-threads?

Unless I am misunderstanding you, even root/root-proc can be hit by a 
runaway, so the threads-max limits this globally which is great, but this 
may lock-you out of being able to control the situation based on uid only.

Thus this patch gives root the ability to allow a certain pid to exceed the 
threads-max limit, while all other pids are still limited.

Your comments are much appreciated!

Thanks!

--
Al

