Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUDCE7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 23:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUDCE7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 23:59:55 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:23004 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261605AbUDCE7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 23:59:51 -0500
Date: Fri, 2 Apr 2004 23:59:48 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Paul Eggert <eggert@gnu.org>, Andi Kleen <ak@suse.de>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, bug-coreutils@gnu.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040403045948.GA21384@pimlott.net>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Paul Eggert <eggert@gnu.org>, Andi Kleen <ak@suse.de>,
	gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
	bug-coreutils@gnu.org
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de> <20040401220957.5f4f9ad2.ak@suse.de> <7w3c7nb4jb.fsf@sic.twinsun.com> <20040402011411.GE28520@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402011411.GE28520@mail.shareable.org>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 02:14:11AM +0100, Jamie Lokier wrote:
> However, sponteneous mtime changes are not polite.  So I broadly agree
> with the principle of:
> 
> Paul Eggert wrote:
> > The only way I can see to satisfy these two principles is to truncate
> > the timestamp right away, when it is first put into the inode cache.
> > That way, the copy in main memory equals what will be put onto disk.
> > This is the approach taken by other operating systems like Solaris,
> > and it explains why parallel GCC builds won't have this problem on
> > these other systems.

So is there any chance in the world that this behavior could be
implemented?  None of the alternatives work, and we now know that the
problem bites.  (I can't even guess how much time Ulrich wasted
diagnosing it.)

> This behaviour was established in 2.5.48, 18th November 2002.

And shown to be broken in October.

Andrew
