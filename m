Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263501AbREYDHV>; Thu, 24 May 2001 23:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263505AbREYDHM>; Thu, 24 May 2001 23:07:12 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:4062 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263501AbREYDHD>;
	Thu, 24 May 2001 23:07:03 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105250307.UAA00899@csl.Stanford.EDU>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 24 May 2001 20:07:00 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105242257280.24864-100000@weyl.math.psu.edu> from "Alexander Viro" at May 24, 2001 11:00:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ah, nice --- I keep meaning to tell the checker to demote its warning
> > about NULL bugs or large stack vars in __init routines and/or routines
> > that have the substring "init" in them ;-)
> 
> Please, don't. These functions are often used from/as init_module(),
> so they must handle the case when allocation fails. They can be
> called long after the boot.

I meant "demote"  to mean "reducing the ranking of these errors during
sorting" rather than "eliminate from the error logs".  


