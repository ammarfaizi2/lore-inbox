Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273896AbRI0VAt>; Thu, 27 Sep 2001 17:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273900AbRI0VAj>; Thu, 27 Sep 2001 17:00:39 -0400
Received: from t2.redhat.com ([199.183.24.243]:54512 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S273896AbRI0VAY>; Thu, 27 Sep 2001 17:00:24 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010927202435.A19466@artax.karlin.mff.cuni.cz> 
In-Reply-To: <20010927202435.A19466@artax.karlin.mff.cuni.cz> 
To: Jan Hudec <bulb@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggest TASK_KILLABLE state to overcome most D state trouble 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Sep 2001 22:00:50 +0100
Message-ID: <19318.1001624450@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bulb@ucw.cz said:
>  Does a patch adding a TASK_KILLABLE state have a chance to get in (in
> 2.5)? Or can anybody thik of more elegant solution?

Often there's kernel state which needs to be kept consistent, and locks
which need to be released - just bailing out (as if you got an oops) isn't
sufficient.

What's wrong with the plan of just implementing the appropriate cleanup code
in each buggy or lazy piece of code which sleeps in state
TASK_UNINTERRUPTIBLE, and letting each be interruptible instead?

--
dwmw2


