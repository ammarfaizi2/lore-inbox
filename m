Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTIJSd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbTIJSdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:33:25 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:657 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S265151AbTIJScr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:32:47 -0400
Date: Wed, 10 Sep 2003 19:31:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030910183138.GA23783@mail.jlokier.co.uk>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com> <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com> <20030910152902.GA2764@elf.ucw.cz> <Pine.LNX.4.53.0309101147040.14762@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309101147040.14762@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> I would guess that the compiler output might be:

Your guess is incorrect.

> You are always going to take an extra jump in one execution
> path after the function, and you will take a conditional jump
> before the function call in the other execution path. So, you
> always have the "extra" jumps, no matter.

That is not true.  The "likely" path has no taken jumps.

Think about the code again.
How would you optimise it, if you were writing assembly language yourself?

(In more complex examples, another factor is that mis-predicted
conditional jumps are much slower than unconditional jumps, so it is
good to favour the latter in the likely path).

-- Jamie
