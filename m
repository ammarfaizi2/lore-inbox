Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVEOMWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVEOMWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVEOMWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:22:39 -0400
Received: from one.firstfloor.org ([213.235.205.2]:9345 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262824AbVEOMWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:22:35 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] i386: enable REGPARM by default
References: <20050515115712.GQ16549@stusta.de>
From: Andi Kleen <ak@muc.de>
Date: Sun, 15 May 2005 14:22:34 +0200
In-Reply-To: <20050515115712.GQ16549@stusta.de> (Adrian Bunk's message of
 "Sun, 15 May 2005 13:57:12 +0200")
Message-ID: <m1acmwadbp.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This patch should _not_ go into Linus' tree.
>
> At some time in the future, we want to unconditionally enable REGPARM on 
> i386.
>
> Let's give it a bit broader testing coverage among -mm users.

iirc problem is that gcc 2.95 and possibly 3.0.x have some known
miscompilations with regparams. That is why it was only used
with fastcall for a long time. One 3.1.x+ it should be safe.
But you cannot express dependencies on the compiler version
in Kconfig right now.

Of course getting rid of gcc 2.95 and 3.0.x support would be a good idea,
that would allow many other nice things.

-Andi

