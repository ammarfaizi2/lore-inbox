Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSGSWrA>; Fri, 19 Jul 2002 18:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSGSWrA>; Fri, 19 Jul 2002 18:47:00 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:56968 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S317181AbSGSWpe>;
	Fri, 19 Jul 2002 18:45:34 -0400
Subject: Re: more thoughts on a new jail() system call
From: Shaya Potter <spotter@cs.columbia.edu>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ah7m2r$3cr$1@abraham.cs.berkeley.edu>
References: <1026959170.14737.102.camel@zaphod> 
	<ah7m2r$3cr$1@abraham.cs.berkeley.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jul 2002 18:48:35 -0400
Message-Id: <1027118916.2635.132.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 20:21, David Wagner wrote:
> Shaya Potter  wrote:
> >sys_mknod) J - Need FIFO ability, everything else not.
> 
> Beware the ability to pass file descriptors across Unix
> domain sockets.  This should probably be restricted somehow.
> Along similar lines, you didn't mention sendmsg() and
> recvmsg(), but the fd-passing parts should probably be
> restricted.

not sure there has to be anything restricted, more so than the
filesystem restrictions already.  As from what I can tell from Stevens
there are 2 ways to pass a fd over an AF_UNIX socket.  either socketpair
(parent/child relationship i.e. both in jail) or a named socket, which
then its constrained to the jailed FS, and therefore only processes in
that particular jail have access to it.

or am I wrong?

thanks,

shaya potter

