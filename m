Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSGECH0>; Thu, 4 Jul 2002 22:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGECHZ>; Thu, 4 Jul 2002 22:07:25 -0400
Received: from [24.114.147.133] ([24.114.147.133]:4994 "EHLO starship")
	by vger.kernel.org with ESMTP id <S315257AbSGECHY>;
	Thu, 4 Jul 2002 22:07:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Date: Fri, 5 Jul 2002 04:11:02 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020619113734.D2658@redhat.com> <E17PyXt-0000hm-00@starship> <20020704101501.A19611@tricia.dyndns.org>
In-Reply-To: <20020704101501.A19611@tricia.dyndns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17QIYp-00061b-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 July 2002 16:15, jlnance@intrex.net wrote:
> On Thu, Jul 04, 2002 at 06:48:45AM +0200, Daniel Phillips wrote:
> > > behaviour under certain application workloads.  With the half-md4, at
> > > least we can expect decent worst-case behaviour unless we're under
> > > active attack (ie. only maliscious apps get hurt).
> > 
> > OK, anti-hash-attack is on the list of things to do, and it's fairly
> > clear how to go about it:
> 
> Is it really worth the trouble and complexity to do anti-hash-attack?
> What is the worst that could happen if someone managed to create a bunch
> of files that hashed to the same value?

Just a slowdown, but in some cases it could be a quadratic slowdown
that could conceivably be turned into a denial of service.  As risks
go, it's a minor one, but there's a straightforward solution with
insignificant cost in either efficiency or code size, so why not do
it.  The overhead is just a data move from the superblock per name 
hash.

-- 
Daniel
