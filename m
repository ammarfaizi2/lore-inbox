Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130749AbRCEXHJ>; Mon, 5 Mar 2001 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130750AbRCEXG7>; Mon, 5 Mar 2001 18:06:59 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:24079 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130749AbRCEXGn>; Mon, 5 Mar 2001 18:06:43 -0500
Date: Tue, 6 Mar 2001 12:06:39 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@cambridge.redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
Message-ID: <20010306120638.A26306@metastasis.f00f.org>
In-Reply-To: <8165.983522444@warthog.cambridge.redhat.com> <Pine.LNX.4.10.10103020949230.25951-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10103020949230.25951-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 02, 2001 at 09:52:35AM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 09:52:35AM -0800, Linus Torvalds wrote:

    Show me numbers for real applications, and I might care. I saw
    barely measurable speedups (and more importantly to me - real
    simplification) by removing it.

Do large numbers of entries hurt? I have an application that when
running for a while ends up with over 2000 entries in /proc/$$/maps
because of the way it works... that is paging is more efficient that
the application swapping data out; so it continually grows until it
can no longer at which point it falls back to using it's own poor
LRU, typically means you get a single process of around 2.9GB.

Everything appears to work... but it does seem a bit clunky that
there are so many vma chunks.

Perhaps the argument here is that glibc or the application should be
fixed?




  --cw
