Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290771AbSAYSSB>; Fri, 25 Jan 2002 13:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSAYSRv>; Fri, 25 Jan 2002 13:17:51 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:29969 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S290783AbSAYSRl>;
	Fri, 25 Jan 2002 13:17:41 -0500
Date: Fri, 25 Jan 2002 11:17:31 -0700
From: Val Henson <val@nmt.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update
Message-ID: <20020125111731.B26874@boardwalk>
In-Reply-To: <20020123171419.29358@mailhost.mipsys.com> <200201232314.g0NNEXe457847@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201232314.g0NNEXe457847@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Wed, Jan 23, 2002 at 06:14:33PM -0500
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 06:14:33PM -0500, Albert D. Cahalan wrote:
> 
> It's a waste to use BAT mappings for the kernel anyway, because
> we try to keep the huge computations and graphics in userspace.
> With page tables under BAT mappings, privileged user code could
> be allowed to steal BAT registers for locked memory or IO memory.

The rationale behind BAT mapping the kernel is that the kernel does not
use any TLB entries, leaving them all for user processes. (As long as
we have < 512MB RAM.)

-VAL
