Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTE3E32 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 00:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTE3E32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 00:29:28 -0400
Received: from cs.rice.edu ([128.42.1.30]:39620 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id S263264AbTE3E31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 00:29:27 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
References: <Pine.LNX.4.44.0305300550130.3609-100000@localhost.localdomain>
From: Scott A Crosby <scrosby@cs.rice.edu>
Organization: Rice University
Date: 29 May 2003 23:42:09 -0500
In-Reply-To: <Pine.LNX.4.44.0305300550130.3609-100000@localhost.localdomain>
Message-ID: <oyd7k89cafy.fsf@bert.cs.rice.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 06:02:18 +0200 (CEST), Ingo Molnar <mingo@elte.hu> writes:

> On 29 May 2003, Scott A Crosby wrote:
> 
> > I have confirmed via an actual attack that it is possible to force the
> > dcache to experience a 200x performance degradation if the attacker can
> > control filenames. On a P4-1.8ghz, the time to list a directory of
> > 10,000 files is 18 seconds instead of .1 seconds.
> 
> are you sure this is a big issue? Kernel 2.0 (maybe even 2.2) lists 10,000
> files at roughly the same speed (18 seconds) without any attack pattern
> used for filenames - still it's a kernel being used.

No. Its not that severe, but it does exist, and it is noticable even
with a quarter that number of files. I did it because it was an
interesting illustrative example, and it only took 30 seconds or so of
coding to put the hash function into generator generating program.

> So it would take a really specialized attack to keep the dcache size
> at the critical level and trigger the slowdown.

Yup. It is probably a very unusual configuration, but that doesn't
mean that somebody won't experience it. :)

Scott
