Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270359AbTGWOdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270360AbTGWOdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:33:20 -0400
Received: from sabre.velocet.net ([216.138.209.205]:19217 "EHLO
	sabre.velocet.net") by vger.kernel.org with ESMTP id S270354AbTGWOdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:33:19 -0400
To: Valdis.Kletnieks@vt.edu
Cc: jimis@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related)
References: <3F1E6A25.5030308@gmx.net>
	<200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
In-Reply-To: <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 23 Jul 2003 10:47:46 -0400
Message-ID: <87oezlqoz1.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Valdis.Kletnieks@vt.edu writes:

> 2) There's a phenomenon called "starvation".  See that 'find' command in your
> example?  If mozilla is disk-hungry enough, bad I/O scheduling can mean that
> 'find' command will sit there *forever*, tying up resources the whole time.
> This can cause issues.  For instance - if you've flagged 'mozilla' as the
> process that gets first shot at the disk, what do you do if you start paging to
> the swap area, and some OTHER process has to read a page in?  What if that
> "other process" is the X server or your window manager?  Think REALLY hard here
> - just saying "I'll renice them too" is NOT the right answer.. .;)

I'm sure it's a serious issue, and yet my network has QoS set up and the low
priority flows still eventually get through just fine even though it has much
lower bandwidth available than my disk controller.

I think it would be really cool to be able to control disk i/o with the same
level of flexibility as network i/o. I could see setting up cbq trees that can
key off things like whether it's paging, a blocking/nonblocking i/o, or a
nonblocking i/o. They could also see what user owns the process, and what
inode the process's executable image is.

I would just wonder about the overhead.

-- 
greg

