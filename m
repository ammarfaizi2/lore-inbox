Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSCUGa4>; Thu, 21 Mar 2002 01:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293453AbSCUGap>; Thu, 21 Mar 2002 01:30:45 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:38046 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S293448AbSCUGac>; Thu, 21 Mar 2002 01:30:32 -0500
Date: Wed, 20 Mar 2002 23:45:52 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020320234552.A21740@vger.timpanogas.org>
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org> <20020320220241.GC29857@matchmail.com> <20020320152008.A19978@vger.timpanogas.org> <20020320152504.B19978@vger.timpanogas.org> <3C9935CA.38E6F56F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 05:22:18PM -0800, Andrew Morton wrote:
> "Jeff V. Merkey" wrote:
> > 
> > ...
> > > I will comply.  I tested with pre-3 patches and still saw this problem??
> > > Let me go and check the patches I applied to verify, I may not have
> > > applied the correct patch.
> > >
> > > Jeff
> > 
> > I verified we were using a stock 2.4.18 kernel on the specific system
> > without the pre-3 patches installed.  We have been testing with the
> > latest patches but not on this system.  We will apply and retest and
> > I will verify.
> > 
> 
> The elevator starvation change went into 2.4.19-pre1 I think.
> It shouldn't affect the problem which you've described - that
> change improved the situation where tasks were sleeping for
> long periods when they want to insert new requests.  But the
> problem which you're observing appears to affect already-inserted
> requests.
> 
> "Several minutes" is downright odd.  From your description
> it seems that all the requests are writes, but some of the
> writes (at a remote end of the disk) are being bypassed far
> too many times.
> 
> The bypass count _is_ tunable.  Although it sounds like the logic
> has come unstuck in some manner, it would be interesting if
> changing the elevator latency parameters for that queue affected
> the situation.
> 
> Have you experimented with `elvtune -r NNN /dev/foo' and
> `elvtune -w NNN /dev/foo'?

No, but I will test this tonight.  I am in tonight working on 
this problem until I run it down.

Jeff


> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
