Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSDMRNY>; Sat, 13 Apr 2002 13:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292666AbSDMRNX>; Sat, 13 Apr 2002 13:13:23 -0400
Received: from imladris.infradead.org ([194.205.184.45]:267 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S292588AbSDMRNX>; Sat, 13 Apr 2002 13:13:23 -0400
Date: Sat, 13 Apr 2002 18:13:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] don't allocate ratnodes under PF_MEMALLOC
Message-ID: <20020413181305.A21838@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CB7D75F.FEE95D28@zip.com.au> <20020413123244.A4470@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 12:32:44PM +0100, Christoph Hellwig wrote:
> 
> I don't like this soloution very - I think porting th add_to_swap() logic
> from -rmap and implementing the flags fiddling in that function makes
> more sense.  I will do so once a -pre4 is out to resync.

Umm, after actually taking a look at the mainline swapout path, a
rmap-like add_to_swap() logic doesn't fit very well.  Go ahead with your
current fix, please.
