Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVE0PZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVE0PZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVE0PZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:25:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:8072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261818AbVE0PZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:25:15 -0400
Date: Fri, 27 May 2005 08:27:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <lenb@toshiba.hsd1.ma.comcast.net>
cc: acpi-devel@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Nyberg <alexn@telia.com>
Subject: Re: [PATCH] ACPI build fix for 2.6.12-rc5
In-Reply-To: <20050527085326.GA29767@toshiba.hsd1.ma.comcast.net>
Message-ID: <Pine.LNX.4.58.0505270815330.17402@ppc970.osdl.org>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
 <20050527085326.GA29767@toshiba.hsd1.ma.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 May 2005, Len Brown wrote:
>
> Linus,
> Please apply this CONFIG_ACPI=n build fix to 2.6.12-rc5

Done.

Just a quick note about the Subject line, though (and this is not 
actually particular to Len at all, it's the second email on this that I 
send out just today ;)..

Since my automated tools will take the Subject line as the changelog
entry, and in fact it gets special treatment and ends up being in
shortlogs and in the gitweb summary pages etc, I like it when the Subject
line is "clean" in the sense that it makes sense in that context.

In particular, it's good for _me_ to know that a patch is against a
certain release (and not a "-mm" tree for example), so I certainly don't
mind seeing the the patch is for "2.6.12-rc5". But once it is in the tree,
that versioning information is pointless, and sometimes even wrong (ie
maybe I ended up actually applying the patch only after I released the
next kernel, and now that very public comment just looks strange).

So unless the version is literally important for the patch itself (ie, it 
might _be_ about the version numbers in the Makefile, and you send in a 
patch that changes the all-important NAME field of a particular release), 
I actually much prefer to see these "meta-comments" inside the [] in the 
Subject line, which automatically gets pruned off by the scripts.

IOW, something like this:

	[PATCH -rc5] ACPI build fix

works well (usually the major release is obvious, which is why I shorted 
it to just that part, but it's all up to you at that point: it will be 
peeled off and just replaced with [PATCH] by the scripts).

So in general, you can have small messages for the patch recipient in
there, but don't go overboard. If it's longer than twenty characters, it 
will usually mean that the _actual_ subject line may not show fully in my 
mail index, of course..

			Linus
