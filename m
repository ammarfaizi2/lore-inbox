Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSJQTfF>; Thu, 17 Oct 2002 15:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261890AbSJQTfF>; Thu, 17 Oct 2002 15:35:05 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:30969 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261856AbSJQTfE>; Thu, 17 Oct 2002 15:35:04 -0400
Date: Thu, 17 Oct 2002 15:41:02 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: statfs64 missing
Message-ID: <20021017154102.D30332@redhat.com>
References: <20021016140658.GA8461@averell> <shs7kgipiym.fsf@charged.uio.no> <15789.64263.606518.921166@wombat.chubb.wattle.id.au> <20021017000111.GA25054@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017000111.GA25054@averell>; from ak@muc.de on Thu, Oct 17, 2002 at 02:01:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 02:01:11AM +0200, Andi Kleen wrote:
...
> So it boils down to if the new fields are important enough to justify
> the pain they cause on 64bit.
> 
> (I ran into a similar issue with my nanosecond stat patchkit - 
> alpha stat is 64bit clean, but doesn't have the padding for ns fields
> added used in later ports)

If any new stat() type syscalls are added, make sure that a length parameter 
of the structure gets passed in from userland, as that way we will be able 
to extend the available information without introducing yet another syscall 
on every arch (this has happened enough times now that we should try to get 
it right).

		-ben
-- 
"Do you seek knowledge in time travel?"
