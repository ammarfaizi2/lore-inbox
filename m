Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288038AbSACAvF>; Wed, 2 Jan 2002 19:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288100AbSACAt3>; Wed, 2 Jan 2002 19:49:29 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:3810 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288096AbSACAtQ>;
	Wed, 2 Jan 2002 19:49:16 -0500
From: dewar@gnat.com
To: dewar@gnat.com, jtv@xs4all.nl
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, jbuck@synopsys.COM, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020103004916.20ABCF2EC4@nile.gnat.com>
Date: Wed,  2 Jan 2002 19:49:16 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<At the risk of going off topic, you can take the non-element's address but
you can't actually touch it.  So provided your architecture supports
pointer arithmetic beyond the end of the segment, your only remaining
worries are (1) that you don't stumble into the NULL address (which need
not be zero), and (2) that the address isn't reused as a valid element of
something else.  I'm not so sure the latter is even a requirement.
>>

Ah! But you can compare it, and on a segmented architecture like the 286,
the address just past the end of the array can wrap to zero if the array
is allocated right up to the end of the segment. This is not theory, at
least one C compiler on the 286 had this bug!
