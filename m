Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281477AbRKHGUJ>; Thu, 8 Nov 2001 01:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRKHGTu>; Thu, 8 Nov 2001 01:19:50 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:39950 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S281477AbRKHGTo>; Thu, 8 Nov 2001 01:19:44 -0500
Date: Thu, 8 Nov 2001 17:19:47 +1100
From: john slee <indigoid@higherplane.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <20011108171947.G2430@higherplane.net>
In-Reply-To: <20011107170836.A4782@hensema.net> <200111080022.fA80MHq68859@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111080022.fA80MHq68859@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 07:22:16PM -0500, Albert D. Cahalan wrote:
> Splitting /proc can be done. Start by mounting procfs twice.
> Make non-process stuff in /proc invisible, but still available.
> Then in /kernel the process stuff can be disabled. The proc fs
> code can even register two filesystem types, with different
                         ^^^^^^^^^^^^^^^^^^^^
			 ||||||||||||||||||||

this is the key part.  two filesystems and union mount should satisfy
backward compatibility needs while lspci and friends are migrating to
/kern.

this makes it a distribution issue, not a kernel issue, and there is no
need for special backwards-compatibility stuff in either kernfs or
procfs.

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
