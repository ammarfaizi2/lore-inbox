Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRIUWo0>; Fri, 21 Sep 2001 18:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274861AbRIUWoS>; Fri, 21 Sep 2001 18:44:18 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30709
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274862AbRIUWoF>; Fri, 21 Sep 2001 18:44:05 -0400
Date: Fri, 21 Sep 2001 15:44:24 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
Message-ID: <20010921154424.C8738@mikef-linux.matchmail.com>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com> <15271.11056.810538.66237@notabene.cse.unsw.edu.au> <20010919133811.B22773@mikef-linux.matchmail.com> <15273.7576.395258.345452@notabene.cse.unsw.edu.au> <20010921141050.A1946@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921141050.A1946@redhat.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 02:10:50PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, Sep 20, 2001 at 08:35:04AM +1000, Neil Brown wrote:
> 
> > However when a RAID rebuild happens, every block on the array is read
> > into the buffer cache (if it isn't already there) and then written
> > back out again.  This defeats the control that ext3 tries to maintain
> > on the buffer cache.
> > 
> > I don't know exactly what large-scale effects this might have.  It
> > could be simply that a crash at the wrong time could leave the
> > filesystem corrupted.
> 
> Immediately after a crash, the fs will be OK.  But during the
> subsequent background raid reconstruction, it can get out of sync
> again.  This can result in silent data loss in some cases, but it is
> also likely to trigger some internal ext3 debugging which detects
> out-of-order data writes, resulting in a kernel panic.
> 

Ok, thanks guys, on ext3-users and lkml.

Now I know that if I want RAID1 or RAID5 with ext3, I'm going to need 2.4...

Test test test...

Mike
