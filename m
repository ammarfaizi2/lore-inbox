Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310672AbSCHD0v>; Thu, 7 Mar 2002 22:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310673AbSCHD0m>; Thu, 7 Mar 2002 22:26:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8202 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310672AbSCHD0b>; Thu, 7 Mar 2002 22:26:31 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Date: 7 Mar 2002 19:26:08 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a69b0g$juo$1@cesium.transmeta.com>
In-Reply-To: <20020307153228.3A6773FE06@smtp.linux.ibm.com> <E16j95K-00047G-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16j95K-00047G-00@wagner.rustcorp.com.au>
By author:    Rusty Russell <rusty@rustcorp.com.au>
In newsgroup: linux.dev.kernel
> 
> > I m not in favor of that. The dominant lock will be mutexes.
> 
> To clarify: I'd love this, but rwlocks in the kernel aren't even
> vaguely fair.  With a steady stream of overlapping readers, a writer
> will never get the lock.
> 

Note that there really are two kinds of rwlocks: rwlocks with read
priority, and rwlocks with write priority.  They're actually fairly
different operations.  I guess one can envision other schemes, too,
but that's the main distinction.

Neither is particularly hard to implement, however, it's probably
better if they are considered different types (perhaps we can call the
ones with write priority "wrlocks" instead of "rwlocks").

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
