Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273415AbRIRTYZ>; Tue, 18 Sep 2001 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273418AbRIRTYP>; Tue, 18 Sep 2001 15:24:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:41714
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273415AbRIRTYJ>; Tue, 18 Sep 2001 15:24:09 -0400
Date: Tue, 18 Sep 2001 12:24:22 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
Message-ID: <20010918122422.B6861@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com> <15271.11056.810538.66237@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15271.11056.810538.66237@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Sep 18, 2001 at 09:08:32PM +1000, Neil Brown wrote:
> On Sunday September 16, mfedyk@matchmail.com wrote:
> > Hi,
> > 
> > I'm trying to setup a 2.2 kernel that I can use for comparison to the latest
> > 2.4 kernels I've been testing, but I came accross a little problem with the
> > patches I've been trying to combine.
> > 
> > I've already applied:
> > ide.2.2.19.05042001.patch
> > linux-2.2.19.kdb.diff
> > linux-2.2.19.ext3.diff
> > 
> > And now I'm trying to apply raid-2.2.19-A1, and I get one reject in
> > include/linux/fs.h.
> 
> You should be aware that ext3 (and other journalling filesystems) do
> not work reliably over RAID1 or RAID5 in 2.2.  Inparticular, you can
> get problems when the array is rebuilding/resyncing.
> 
> But if you only plan to use ext3 with raid0 or linear, you should be
> fine.
> 

Crap.

I was just about to test ext3 on a raid1 with 2.2.20pre.  Everything else
I've tried has worked great.

As it looks, this probably won't be fixed in 2.2, especially since the raid
patch won't be merged into 2.2 (as stated by Alan).

I'll just have to test 2.4 harder now.  2.4.x-ac has been pretty good
concerning swap usage, and performance on my workstations.  I hope 2.4.10
will merge those improvements.

Mike
