Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318356AbSH0DiO>; Mon, 26 Aug 2002 23:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSH0DiO>; Mon, 26 Aug 2002 23:38:14 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:48886 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318356AbSH0DiN>; Mon, 26 Aug 2002 23:38:13 -0400
Date: Mon, 26 Aug 2002 23:42:30 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@arcor.de>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
Message-ID: <20020826234230.B21820@redhat.com>
References: <3D644C70.6D100EA5@zip.com.au> <E17jO6g-0002XU-00@starship> <20020826200048.3952.qmail@thales.mathematik.uni-ulm.de> <E17jQB8-0002Zi-00@starship> <3D6A9E4D.DBCC5D0A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6A9E4D.DBCC5D0A@zip.com.au>; from akpm@zip.com.au on Mon, Aug 26, 2002 at 02:31:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 02:31:57PM -0700, Andrew Morton wrote:
> I like the magical-removal-just-before-free, and my gut feel is that
> it'll provide a cleaner end result.

For the record, I'd rather see explicite removal everwhere.  We received 
a number of complaints along the lines of "I run my app immediately after 
system startup, and it's fast, but the second time it's slower" due to 
the lazy page reclaim in early 2.4.  Until there's a way to make LRU 
scanning faster than page allocation, it can't be lazy.

		-ben
