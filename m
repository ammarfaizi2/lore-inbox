Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVDIUlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVDIUlp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 16:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVDIUlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 16:41:45 -0400
Received: from webmail.topspin.com ([12.162.17.3]:47012 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261382AbVDIUlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 16:41:44 -0400
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: memory_barrier
X-Message-Flag: Warning: May contain useful information
References: <1113071696.3383.7.camel@localhost.localdomain>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 09 Apr 2005 12:28:00 -0700
In-Reply-To: <1113071696.3383.7.camel@localhost.localdomain> (Bart De
 Schuymer's message of "Sat, 09 Apr 2005 18:34:56 +0000")
Message-ID: <52d5t33g3j.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Apr 2005 19:28:00.0749 (UTC) FILETIME=[3DFFA9D0:01C53D3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bart> Hi, Is there any reason why __memory_barrier() is still
    Bart> referenced in the kernel source?

    Bart> grep -r memory_barrier gave the following back, which at
    Bart> first seems to suggest barrier() is defined using some
    Bart> phantom __memory_barrier(), quite deceiving...

Notice that it's used in <linux/compiler-intel.h> -- the Intel
compiler has an intrinsic called __memory_barrier().  So the
definition of barrier() using this intrinsic is entirely correct and
appropriate.

 - R.
