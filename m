Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317798AbSFSHMr>; Wed, 19 Jun 2002 03:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317800AbSFSHMq>; Wed, 19 Jun 2002 03:12:46 -0400
Received: from holomorphy.com ([66.224.33.161]:5816 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317798AbSFSHMo>;
	Wed, 19 Jun 2002 03:12:44 -0400
Date: Wed, 19 Jun 2002 00:12:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, Alexander Viro <viro@math.psu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH+discussion] symlink recursion
Message-ID: <20020619071210.GG25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <UTC200206182219.g5IMJru27250.aeb@smtp.cwi.nl> <Pine.LNX.4.33.0206181646220.2562-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0206181646220.2562-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 04:57:06PM -0700, Linus Torvalds wrote:
> I see no advantages to handling it by hand, since this isn't even a very
> deep recursion, and since even if you do the recursive part by hand by a
> linked list you still need to limit the depth _anyway_ to avoid DoS
> attacks.

I see one: the space consumed by the explicitly managed stack is
known and control may be exerted over it. Also, the stack space
consumed by procedure calls is great enough on various non-x86 cpus
to make even shallow recursions problematic (ISTR 96B-120B/call with
a 4KB page in some prior discussions).


Cheers,
Bill
