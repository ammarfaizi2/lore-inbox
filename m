Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTJILWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 07:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTJILWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 07:22:31 -0400
Received: from colin2.muc.de ([193.149.48.15]:34576 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262041AbTJILWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 07:22:30 -0400
Date: 9 Oct 2003 13:22:45 +0200
Date: Thu, 9 Oct 2003 13:22:45 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bos@serpentine.com
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
Message-ID: <20031009112245.GA59762@colin2.muc.de>
References: <20031009104218.GA1935@averell> <20031009104918.GB4699@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009104918.GB4699@actcom.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 12:49:18PM +0200, Muli Ben-Yehuda wrote:
> On Thu, Oct 09, 2003 at 12:42:18PM +0200, Andi Kleen wrote:
> 
> > I added a new argument force==2 to get_user_pages that means to ignore
> > SIGBUS or unaccessible pages errors. MAY_* is still checked for like
> > with the old force ==1, it just doesn't error out now for SIGBUS
> > errors on handle_mm_fault. 
> 
> How about making it an enum or define for code readability? I'd much
> rather see an IGNORE_BAD_PAGES or some such than a cryptic '2' in the
> code. I can send a patch to that effect if you'd like? 

Doesn't look essential. You could submit it as a follow-up patch as soon
as Linus merged this version, but I'm not sure it satisfies the current
"no more cleanups" rule because it isn't a bugfix.

-Andi
