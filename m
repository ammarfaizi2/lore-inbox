Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269404AbUIYTxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269404AbUIYTxj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269405AbUIYTxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:53:39 -0400
Received: from dp.samba.org ([66.70.73.150]:54946 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269404AbUIYTxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:53:36 -0400
Date: Sat, 25 Sep 2004 12:52:56 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeremy Allison <jra@samba.org>,
       YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925195256.GB580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1> <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:20:20PM -0700, Linus Torvalds wrote:
> 
> Because right now the number is meaningless, and the Linux client is 
> apparently better off ignoring it totally.

Actually, just to be clear - the number isn't completely
meaningless, it's the actual size on disk (from the st_blocks
if they're available, filesize if not) rounded up to the nearest
1mb boundary. Just didn't want you to think we were randomly
returning 1mb. It's a meaningful number, it's just the granularity
that's a bit off :-).

Jeremy.
