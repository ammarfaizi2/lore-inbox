Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318269AbSIBM0e>; Mon, 2 Sep 2002 08:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318282AbSIBM0e>; Mon, 2 Sep 2002 08:26:34 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:55937 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318269AbSIBM0b>; Mon, 2 Sep 2002 08:26:31 -0400
Date: Mon, 2 Sep 2002 13:30:26 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jani Monoses <jani@iv.ro>, linux-kernel@vger.kernel.org,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] 2.5.32 : u.ext3_sb -> generic_sbp
Message-ID: <20020902133026.A4105@redhat.com>
References: <Pine.LNX.4.21.0001010429580.1200-100000@localhost.localdomain> <3D6FC178.CC3E89CD@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6FC178.CC3E89CD@zip.com.au>; from akpm@zip.com.au on Fri, Aug 30, 2002 at 12:03:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 30, 2002 at 12:03:20PM -0700, Andrew Morton wrote:

> > This turns the remaining parts of ext3 to EXT3_SB and turns the latter
> > from a macro to inline function which returns the generic_sbp field of u.
 
> It's not going to make the merge of all Stephen's 2.4 changes
> any more fun though ;)

For the major new changes in ext3, I think I'll end up bringing back a
lot of the 2.5 changes into a 2.4 branch.  Beyond a certain point,
though, I'll probably have to start basing new ext3 work on 2.5 ---
the BKL mitigation, in particular, is going to depend on the locking
regime which is substantially different in 2.5.  

My current codebase should help BKL in both 2.4 and 2.5 simply because
it substantially reduces the amount of work we're doing in the core,
without actually changing the locking, but eliminating BKL entirely in
larger chunks of the code will have to be the next stage.

--Stephen
