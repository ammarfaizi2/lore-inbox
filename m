Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312532AbSDEMuw>; Fri, 5 Apr 2002 07:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312556AbSDEMul>; Fri, 5 Apr 2002 07:50:41 -0500
Received: from sebula.traumatized.org ([193.121.72.130]:6785 "EHLO
	sparkie.is.traumatized.org") by vger.kernel.org with ESMTP
	id <S312529AbSDEMud>; Fri, 5 Apr 2002 07:50:33 -0500
Date: Fri, 5 Apr 2002 14:46:16 +0200
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre6 doesn't compile on Alpha and sparc64
Message-ID: <20020405124616.GE22422@sparkie.is.traumatized.org>
In-Reply-To: <20020405105409.GA29804@alpha.of.nowhere> <Pine.GSO.4.21.0204050636100.25849-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i (Linux 2.4.19-pre5 sparc64)
X-unexpected: Noone expects the unexpected header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 02:00:14PM +0200, Alexander Viro wrote:
> 
> > init/do_mounts.c:45: parse error before `mount_initrd'
> [snip]
> 
> Looks like a missing init.h - sorry, this sucker didn't get caught (on
> x86 slab.h ends up pulling it in, on alpha it doesn't).
> 
> Fix: add #include <linux/init.h> in init/do_mounts.c

same on sparc64.
adding the extra #include fixes it.


Jurgen.
