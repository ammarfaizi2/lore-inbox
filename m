Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbTIBAQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 20:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTIBAQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 20:16:59 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:16035
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263371AbTIBAPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 20:15:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ian Kumlien <pomac@vapor.com>, Daniel Phillips <phillips@arcor.de>
Subject: Re: [SHED] Questions.
Date: Tue, 2 Sep 2003 10:23:24 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
References: <1062324435.9959.56.camel@big.pomac.com> <200309011707.20135.phillips@arcor.de> <1062457396.9959.243.camel@big.pomac.com>
In-Reply-To: <1062457396.9959.243.camel@big.pomac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309021023.24763.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Sep 2003 09:03, Ian Kumlien wrote:
> On Mon, 2003-09-01 at 17:07, Daniel Phillips wrote:
> > IMHO, this minor change will provide a more solid, predictable base for
> > Con and Nick's dynamic priority and dynamic timeslice experiments.
>
> Most definitely.

No, the correct answer is maybe... if after it's redesigned and put through 
lots of testing to ensure it doesn't create other regressions. I'm not saying 
it isn't correct, just that it's a major architectural change you're 
promoting. Now isn't the time for that.

Why not just wait till 2.6.10 and plop in a new scheduler a'la dropping in a 
new vm into 2.4.10... <sigh> 

The cpu scheduler simply isn't broken as the people on this mailing list seem 
to think it is. While my tweaks _look_ large, they're really just tweaking 
the way the numbers feed back into a basically unchanged design. All the 
incremental changes have been modifying the same small sections of sched.c 
over and over again. Nick's changes change the size of timeslices and the 
priority variation in a much more fundamental way but still use the basic 
architecture of the scheduler. 

Promoting a new scheduler design entirely is admirable and ultimately probably 
worth pursuing but not 2.6 stuff.

Con

