Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312970AbSC0C2W>; Tue, 26 Mar 2002 21:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312971AbSC0C2C>; Tue, 26 Mar 2002 21:28:02 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:17135
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312970AbSC0C1z>; Tue, 26 Mar 2002 21:27:55 -0500
Date: Tue, 26 Mar 2002 18:29:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Anders Peter Fugmann <afu@fugmann.dhs.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre4-ac1
Message-ID: <20020327022906.GG3536@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Anders Peter Fugmann <afu@fugmann.dhs.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16pvYV-0003cD-00@the-village.bc.nu> <3CA0EAAA.8000400@fugmann.dhs.org> <15520.61687.962869.841296@notabene.cse.unsw.edu.au> <3CA1081D.7040101@fugmann.dhs.org> <15521.10564.475227.372522@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 01:07:00PM +1100, Neil Brown wrote:
> On Wednesday March 27, afu@fugmann.dhs.org wrote:
> > Thanks.
> > 
> > It seems that there is some more problems.
> > I have not verified the lookup (since I just booted right away with the patch), but
> > I have found that:
> > 
> > Mar 26 23:56:58 gw kernel: nfsd: LOOKUP(3)   24: 03000001 03000900 00000002 0000106d 0000106c 0000070d WMRootMenu
> > Mar 26 23:56:58 gw kernel: RPC request reserved 240 but used 244
> > 
> > Mar 27 00:30:09 gw kernel: nfsd: CREATE(3)   24: 03000001 03000900 00000002 00000003 00000002 00000000 test
> > Mar 27 00:30:09 gw kernel: RPC request reserved 272 but used 276
> > 
> > Mar 27 00:30:21 gw kernel: nfsd: SYMLINK(3)  24: 03000001 03000900 00000002 00000003 00000002 00000000 test1 -> test
> > Mar 27 00:30:21 gw kernel: RPC request reserved 272 but used 276
> > 
> > And there might be others.
> 
> I bet you're using reisferfs ???
> 
> It occasionaly uses filehandles longer than 32 bytes (the max for
> NFSv2) and my calculations forgot that nfsv3 allows for 64 bytes.
> So "9" (8 longs and a count) should be "17" (16 longs and a count).
>

Why aren't you using defines with comments in effect to the above?
