Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbRBYLD3>; Sun, 25 Feb 2001 06:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRBYLDU>; Sun, 25 Feb 2001 06:03:20 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:63501 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129608AbRBYLDO>; Sun, 25 Feb 2001 06:03:14 -0500
Date: Mon, 26 Feb 2001 00:03:09 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Core dumps for threads
Message-ID: <20010226000309.B12962@metastasis.f00f.org>
In-Reply-To: <20010224134523.O26109@valinux.com> <E14WmhG-0000Yj-00@the-village.bc.nu> <20010225221505.A12595@metastasis.f00f.org> <oupk86fjbup.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <oupk86fjbup.fsf@pigdrop.muc.suse.de>; from ak@suse.de on Sun, Feb 25, 2001 at 11:28:14AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 11:28:14AM +0100, Andi Kleen wrote:

    It would need a recursive mm semaphore -- core dumps can page
    fault and page faults take the semaphore again. Other alternative
    is to copy the MM like fork before dumping, but then core dumping
    could fail much quicker when you ran out of memory.

Ouch... would creating another semaphore or flag 'dumping_core' work
or is that jut a bad idea?

I ask this because like it or not; people use threaded applications
and having threaded core dumps would be cool. Requiring a copy to
dump isn't really elegant or an option if you run a process who's RSS
is 400M on a 512MB machine as I do.




  --cw
