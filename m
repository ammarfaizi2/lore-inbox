Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266806AbUG1IKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266806AbUG1IKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 04:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbUG1IHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 04:07:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4294 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266820AbUG1IGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 04:06:04 -0400
Date: Wed, 28 Jul 2004 01:05:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-Id: <20040728010546.3b7933d5.pj@sgi.com>
In-Reply-To: <200407222204.46799.rob@landley.net>
References: <200407222204.46799.rob@landley.net>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob wrote:
> I just saw a funky thing.  Here's the cut and past from the xterm...

Can you reproduce this by cat'ing /proc/<pid>/cmdline?  Can you get a
dump of the proc cmdline file to leak the environment sometimes?

It is this file that 'ps' is dumping for these options.  Adding the
'e' option would also dump the /proc/<pid>/environ file (if readable).

But you aren't adding 'e', so presumably the environment is "leaking"
into the the cmdline file.

I suspect a kernel bug here - the ps code seems rather obvious and
unimpeachable.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
