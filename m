Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269396AbUIYTUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269396AbUIYTUu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269399AbUIYTUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:20:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:10180 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269396AbUIYTUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:20:34 -0400
Date: Sat, 25 Sep 2004 12:20:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Allison <jra@samba.org>
cc: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
In-Reply-To: <20040925182907.GS580@jeremy1>
Message-ID: <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org>
 <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1>
 <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1>
 <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Sep 2004, Jeremy Allison wrote:
> 
> Also, the minumum size isn't the same issue as the st_blocks
> issue.

Well, it _is_.

Because right now the number is meaningless, and the Linux client is 
apparently better off ignoring it totally.

Which was kind of my point to begin with.

If the number doesn't make sense, then we shouldn't look at it. The 
_only_ thing that number makes sense for is st_blocks as far as the Linux 
client is concerned. 

In other words, the Linux client is a hell of a lot better off just taking 
"(filesize + 511) >> 9", as far as I can tell. It's more accurate than the 
random number you have.

		Linus
