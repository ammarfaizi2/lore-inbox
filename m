Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312606AbSDFRFo>; Sat, 6 Apr 2002 12:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312608AbSDFRFn>; Sat, 6 Apr 2002 12:05:43 -0500
Received: from bitmover.com ([192.132.92.2]:7380 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S312606AbSDFRFm>;
	Sat, 6 Apr 2002 12:05:42 -0500
Date: Sat, 6 Apr 2002 09:05:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Larry McVoy <lm@bitmover.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1
Message-ID: <20020406090540.B12017@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Larry McVoy <lm@bitmover.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020404223425.K11833@suse.de> <20020403195445.U17549@work.bitmover.com> <Pine.LNX.4.33.0204041203440.14206-100000@penguin.transmeta.com> <20020404223425.K11833@suse.de> <22175.1018107407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 04:36:47PM +0100, David Woodhouse wrote:
> 
> davej@suse.de said:
> > With Marcelo using bk these days, is it possible that you can cherry
> > pick certain csets from his bk tree ?
> 
> I couldn't work out how to make BK even attempt that. 
> 
> If you commit harmless and irrelevant changeset 'X' to a repository, then 
> commit a completely separate changeset 'Y' which doesn't touch any of the 
> same files, then it seems to be impossible¹ to import 'Y' into a different 
> tree without also importing 'X'.

If you want to do it preserving all the BK info, i.e., a pull with some
option to send a particular changeset, that doesn't work.  BK has an 
invariant which is that the parent of any changeset you send must be
present in the receiving repository or it won't work.

What you want to do is cherrypick, to do that with BK you have two choices:
    a) wait for LODs
    b) export as a patch and import as a patch.
The second one works fine but causes problems over the long run, especially
with file creates.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
