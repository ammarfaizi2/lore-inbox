Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTIUPNu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 11:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTIUPNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 11:13:50 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22684
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262423AbTIUPNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 11:13:48 -0400
Date: Sun, 21 Sep 2003 17:14:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: A couple of 2.4.23-pre4 VM nits
Message-ID: <20030921151418.GA29703@velociraptor.random>
References: <20030921140404.GA16399@velociraptor.random> <20030921145127.39547.qmail@web12811.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921145127.39547.qmail@web12811.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 07:51:27AM -0700, Shantanu Goel wrote:
> I just realized the original code had one desirable
> behaviour that my patch is missing, namely, it
> reclaimed memory from dcache/inode every time swap_out
> is called.  Please use the attached patch that
> restores the original behaviour.  Otherwise, if the
> interval is very long, no reclamation will happen
> until swap_out() fails which in the common case is
> unlikely.

I overlooked the *failed_swapout, I thought you used only 0 and 1 as
parameters, the new version is fine.

BTW, it would also be cleaner to add a __ in front of the function name,
and to #define a _force version that will pass 1, so you don't have less
readable 0/1 in the caller, but I don't mind even with the status in
version 2 (it's simple enough to understand the semantics of the 0/1).

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
