Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272393AbRIKLMH>; Tue, 11 Sep 2001 07:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272401AbRIKLL6>; Tue, 11 Sep 2001 07:11:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:48923 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272393AbRIKLLt>; Tue, 11 Sep 2001 07:11:49 -0400
Date: Tue, 11 Sep 2001 13:12:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Maneesh Soni <smaneesh@sequent.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911131238.N715@athlon.random>
In-Reply-To: <20010911150946.A14621@sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010911150946.A14621@sequent.com>; from smaneesh@sequent.com on Tue, Sep 11, 2001 at 03:09:46PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2001 at 03:09:46PM +0530, Maneesh Soni wrote:
> 
> In article <20010910200344.C714@athlon.random> you wrote:
> > Long term of course, but with my further changes before the inclusion
> > the plain current patches shouldn't apply any longer, I'd like if the
> > developers of the current rcu fd patches could check my changes and
> > adapt them (if they agree with my changes of course ;).
> 
> Hello Andrea,
> 
> I have noted your changes and I am modifying the FD patch accordingly. In fact
> in the first version of FD patch I have used the rc_callback() interface which
> equivalent to call_rcu(). 

many thanks. At the moment my biggest concern is about the need of
call_rcu not to be starved by RT threads (keventd can be starved so then
it won't matter if krcud is RT because we won't start using it).  But I
don't have concerns about the API so those issues will be transparent to
the FD patch.

Andrea
