Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVECBR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVECBR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 21:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVECBR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 21:17:58 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:34255 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261273AbVECBRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 21:17:51 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
To: Linus Torvalds <torvalds@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>,
       Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 03 May 2005 03:16:26 +0200
References: <3YQn9-8qX-5@gated-at.bofh.it> <3ZLEF-56n-1@gated-at.bofh.it> <3ZM7L-5ot-13@gated-at.bofh.it> <3ZN3P-69A-9@gated-at.bofh.it> <3ZNdz-6gK-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On Mon, 2 May 2005, Ryan Anderson wrote:
>> On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:

>> > That said, I think the /usr/bin/env trick is stupid too. It may be more
>> > portable for various Linux distributions, but if you want _true_
>> > portability, you use /bin/sh, and you do something like
>> > 
>> > #!/bin/sh
>> > exec perl perlscript.pl "$@"
>> if 0;

exec may fail.

#!/bin/sh
exec perl -x $0 ${1+"$@"} || exit 127
#!perl

>> You don't really want Perl to get itself into an exec loop.
> 
> This would _not_ be "perlscript.pl" itself. This is the shell-script, and
> it's not called ".pl".

In this thread, it originally was.
-- 

"Our parents, worse than our grandparents, gave birth to us who are worse than
they, and we shall in our turn bear offspring still more evil."
        -- Horace (BC 65-8)

