Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317346AbSFLWiz>; Wed, 12 Jun 2002 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSFLWiy>; Wed, 12 Jun 2002 18:38:54 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:757 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317346AbSFLWix>; Wed, 12 Jun 2002 18:38:53 -0400
Date: Wed, 12 Jun 2002 18:38:54 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Message-ID: <20020612183854.B4081@redhat.com>
In-Reply-To: <20020612175127.A4081@redhat.com> <Pine.GSO.4.21.0206121824140.16357-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 06:26:55PM -0400, Alexander Viro wrote:
> Not realistic - we have a recursion through the ->follow_link(), and
> a lot of stuff can be called from ->follow_link().  We _do_ have a
> limit on depth of recursion here, but it won't be fun to deal with.

Perfection isn't what I'm looking for, rather just an approximation.  
Any tool would have to give up on non-trivial recursion, or have 
additional rules imposed on the system.  Checker seems to be growing 
functionality in this area, so it seems like a useful feature request.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
