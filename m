Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbTJIQek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTJIQek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:34:40 -0400
Received: from colin2.muc.de ([193.149.48.15]:4619 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262187AbTJIQei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:34:38 -0400
Date: 9 Oct 2003 18:34:54 +0200
Date: Thu, 9 Oct 2003 18:34:53 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       bos@serpentine.com
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
Message-ID: <20031009163453.GA977@colin2.muc.de>
References: <20031009153317.GA3096@averell> <Pine.LNX.4.44.0310090837490.10041-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310090837490.10041-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 08:40:09AM -0700, Linus Torvalds wrote:
> 
> On Thu, 9 Oct 2003, Andi Kleen wrote:
> > 
> > Ok, here's a new version.
> 
> Still won't work.
> 
> You need to call mlock_fixup() to split the vma properly (it might not 
> cover the whole vma, and we _do_ want to keep track of the VM_LOCKED flag 
> correctly.

I don't think so. mlockall() should never split anything.

mlock may, but I didn't change its behaviour. 

-Andi

