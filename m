Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293236AbSCAQY5>; Fri, 1 Mar 2002 11:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293245AbSCAQYq>; Fri, 1 Mar 2002 11:24:46 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:15246 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293236AbSCAQYc>; Fri, 1 Mar 2002 11:24:32 -0500
Date: Fri, 01 Mar 2002 10:24:30 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: thread groups bug? 
Message-ID: <36310000.1014999870@baldur>
In-Reply-To: <Pine.LNX.4.33.0202281616510.31454-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202281616510.31454-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, February 28, 2002 16:20:21 -0800 Linus Torvalds
<torvalds@transmeta.com> wrote:

> Maybe killing the other threads on execve _is_ the right thing after all, 
> if that also gives us POSIX behaviour.
> 
> Who actually maintains the pthread library? I don't think they use 
> CLONE_THREAD at all yet, right?

As far as I know, Linuxthreads is maintained by Ullrich Drepper, and it
doesn't use CLONE_THREAD.  IBM's NGPT pthread library does use
CLONE_THREAD, and I'm the one who's handling kernel issues related to it.

I could code up something that does a 'kill the thread group on execve' if
you'd like me to.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

