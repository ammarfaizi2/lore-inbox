Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272490AbTGZOOC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272491AbTGZOOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:14:02 -0400
Received: from exchfe1.cs.cornell.edu ([128.84.97.27]:5585 "EHLO
	exchfe1.cs.cornell.edu") by vger.kernel.org with ESMTP
	id S272490AbTGZOOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:14:00 -0400
From: Eli Barzilay <eli@barzilay.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16162.36920.524493.883769@mojave.cs.cornell.edu>
Date: Sat, 26 Jul 2003 10:29:12 -0400
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repost: Bug with select?
In-Reply-To: <877k66qg56.fsf@ceramic.fifi.org>
References: <16112.10166.989608.288954@mojave.cs.cornell.edu>
	<16159.28266.868297.372200@mojave.cs.cornell.edu>
	<877k66qg56.fsf@ceramic.fifi.org>
X-Mailer: VM 7.15 under Emacs 21.1.1
X-OriginalArrivalTime: 26 Jul 2003 14:28:56.0406 (UTC) FILETIME=[3EFBF760:01C35382]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25, Philippe Troin wrote:
> Looks like a bug to me.
> Strace says:
> 
> select(2, NULL, [1], NULL, NULL)        = 1 (out [1])
> write(1, "hi\n", 3)                     = -1 EAGAIN (Resource temporarily unavailable)
> 
> forever.
> 
> Then select() should not return fd 1 as writable, at least not
> reapeatedly.

Exactly -- I didn't even think of using strace where this is made
obvious.  (I don't have any solaris where I can run strace, but I
wonder what does that say.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                  http://www.barzilay.org/                 Maze is Life!
