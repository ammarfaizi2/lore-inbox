Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSHBVJg>; Fri, 2 Aug 2002 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSHBVJg>; Fri, 2 Aug 2002 17:09:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18099 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S316928AbSHBVJg>;
	Fri, 2 Aug 2002 17:09:36 -0400
Date: Fri, 02 Aug 2002 16:12:53 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Bill Abt <babt@us.ibm.com>
Subject: Re: [PATCH 2.5.30] Allow tasks to share credentials
Message-ID: <111710000.1028322773@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0208021016580.914-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208021016580.914-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, August 02, 2002 10:22:54 AM -0700 Linus Torvalds
<torvalds@transmeta.com> wrote:

> But I _know_, for example, that this is just a horrid security hole the
> way it is now - the execve() path doesn't create a unique "cred"
> structure, so if you execve() a suid binary from a CLONE_CRED thread, the
> other threads get the suid'ness and can do whatever they want.

You are entirely correct.  It was an oversight on my part.  execve() should
always unshare the cred structure.  I'll work up a fixed version.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

