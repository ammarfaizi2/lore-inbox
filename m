Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263799AbREYQgD>; Fri, 25 May 2001 12:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263802AbREYQfy>; Fri, 25 May 2001 12:35:54 -0400
Received: from [207.213.212.4] ([207.213.212.4]:29317 "EHLO geos.coastside.net")
	by vger.kernel.org with ESMTP id <S263799AbREYQfl>;
	Fri, 25 May 2001 12:35:41 -0400
Mime-Version: 1.0
Message-Id: <p05100308b73439980162@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.33.0105250836400.30357-100000@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.33.0105250836400.30357-100000@twinlark.arctic.org>
Date: Fri, 25 May 2001 09:34:31 -0700
To: dean gaudet <dean-list-linux-kernel@arctic.org>, Andi Kleen <ak@suse.de>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Keith Owens <kaos@ocs.com.au>, Andreas Dilger <adilger@turbolinux.com>,
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:45 AM -0700 2001-05-25, dean gaudet wrote:
>i think it really depends on how you use current -- here's an alternative
>usage which can fold the extra addition into the structure offset
>calculations, and moves the task struct to the top of the stack.
>
>not that this really solves anything, 'cause a stack underflow will just
>trash something else rather than the task struct :)

It would open the door for putting a guard page (which only occupies 
virtual space, after all) below the stack. I have no idea whether 
that's practical, given other constraints, but it's a potential 
benefit of having the stack at the bottom rather than the top of a 
page.
-- 
/Jonathan Lundell.
