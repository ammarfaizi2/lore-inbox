Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262673AbTCYOmO>; Tue, 25 Mar 2003 09:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbTCYOmO>; Tue, 25 Mar 2003 09:42:14 -0500
Received: from almesberger.net ([63.105.73.239]:6663 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262673AbTCYOmN>; Tue, 25 Mar 2003 09:42:13 -0500
Date: Tue, 25 Mar 2003 11:53:15 -0300
From: Werner Almesberger <wa@almesberger.net>
To: raj <raj@cs.wisc.edu>, linux-kernel@vger.kernel.org, zandy@cs.wisc.edu
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
Message-ID: <20030325115315.B7414@almesberger.net>
References: <1047936295.3e763d273307c@www-auth.cs.wisc.edu> <20030324040908.GA19754@nevyn.them.org> <3E7EA4B2.5010306@cs.wisc.edu> <20030324150552.GA26287@nevyn.them.org> <20030325104842.A7468@almesberger.net> <20030325135802.GA13406@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325135802.GA13406@nevyn.them.org>; from dan@debian.org on Tue, Mar 25, 2003 at 08:58:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> Have you got an example that needs this?

No, I was just suggesting an approach that may work, in case
somebody wants to fix this. SIGSTOP/CONT doesn't seem like a
very popular communication mechanism anyway.

I did notice that two processes trying to ptrace each other
end up being unkillably deadlocked on 2.4.18, which a fix
for the SIGSTOP problem may resolve, but I didn't check if
this still happens in more recent kernels. ("Don't do it" is
a satisfactory work-around.)

I'll worry about such subtleties once I've made heads and
tails of how UML's ptrace-relay interacts with process
termination :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
