Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVHUXhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVHUXhz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 19:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVHUXhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 19:37:54 -0400
Received: from rain.plan9.de ([193.108.181.162]:11696 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S1751133AbVHUXhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 19:37:54 -0400
Date: Mon, 22 Aug 2005 01:37:53 +0200
From: Marc Lehmann <schmorp@schmorp.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at "fs/exec.c":777
Message-ID: <20050821233753.GB5027@schmorp.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050818021908.GA11047@schmorp.de> <20050821014945.52df641e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050821014945.52df641e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 01:49:45AM -0700, Andrew Morton <akpm@osdl.org> wrote:
> Marc Lehmann <schmorp@schmorp.de> wrote:
> >
> > If wanted, I can probably reproduce
> > that without the nvidia kernel module loaded.
> > 
> 
> Yes, please do that, thanks.

Ooops, you are not Alexander Nyberg :) Sorry, to give my previous reply
more context: I had a conversation with Alexander Nyberg who wanted to
debug this problem this weekend, and I gave detailed instructions on how
to reproduce it (which is a bit awkward). I also wrote a script that
doesn't rely on X running, but triggers the bug much less often (in fact,
only twice for me so far), and then it seems only the first time after
reboot (which *could* be caused by the very different timing of the
stat()-threads due to the extra disk access).

Let's see what Alexander found out (if he found time). The problem does
not happen (or is not reproducible) with newer IO::AIO releases, as that
one doesn't start threads in the child after the fork/before the exec.

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
