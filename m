Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUG1LxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUG1LxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 07:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUG1LxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 07:53:08 -0400
Received: from pop.gmx.de ([213.165.64.20]:16014 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266884AbUG1LxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 07:53:02 -0400
X-Authenticated: #1725425
Date: Wed, 28 Jul 2004 13:54:44 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Paul Jackson <pj@sgi.com>
Cc: rob@landley.net, linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-Id: <20040728135444.79e67ea9.Ballarin.Marc@gmx.de>
In-Reply-To: <20040728010546.3b7933d5.pj@sgi.com>
References: <200407222204.46799.rob@landley.net>
	<20040728010546.3b7933d5.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004 01:05:46 -0700
Paul Jackson <pj@sgi.com> wrote:

> Rob wrote:
> > I just saw a funky thing.  Here's the cut and past from the xterm...
> 
> Can you reproduce this by cat'ing /proc/<pid>/cmdline?  Can you get a
> dump of the proc cmdline file to leak the environment sometimes?
> 
> It is this file that 'ps' is dumping for these options.  Adding the
> 'e' option would also dump the /proc/<pid>/environ file (if readable).
> 
> But you aren't adding 'e', so presumably the environment is "leaking"
> into the the cmdline file.
> 
> I suspect a kernel bug here - the ps code seems rather obvious and
> unimpeachable.
> 

I ran the following loop for a while (> 9 million times) and could not
reproduce the bug, but that might just be coincidence.
Conditions were the same as in my other, succesful test.

while [ 1 ];do
        cat /proc/self/cmdline >> TEST
done

Marc
