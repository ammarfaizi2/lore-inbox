Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUITJUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUITJUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 05:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUITJUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 05:20:48 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:50363 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266175AbUITJUh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 05:20:37 -0400
X-Envelope-From: kraxel@bytesex.org
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: bttv update
References: <20040916091505.GA11528@bytesex>
	<20040917225105.GA11971@us.ibm.com>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 20 Sep 2004 11:11:33 +0200
In-Reply-To: <20040917225105.GA11971@us.ibm.com>
Message-ID: <87hdpt1f0a.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan <nacc@us.ibm.com> writes:

> > -		set_current_state(TASK_INTERRUPTIBLE);
> > -		schedule_timeout(HZ/50);
> > +		msleep(10);
> 
> My original patch used
> 
> msleep(20);
>
> Is there a reason the conversion was changed?

Doesn't really matter.  The code just polls in a loop until the status
register says the pll is locked.  Usually it needs one round only, so
the delay can be smaller to make the function return earlier ;)

  Gerd

-- 
return -ENOSIG;
