Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSIXMuR>; Tue, 24 Sep 2002 08:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSIXMuR>; Tue, 24 Sep 2002 08:50:17 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:10250 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261663AbSIXMuO>; Tue, 24 Sep 2002 08:50:14 -0400
Date: Tue, 24 Sep 2002 13:55:27 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] oprofile 2.5.38 patch
Message-ID: <20020924125527.GA53972@compsoc.man.ac.uk>
References: <20020923222933.GA33523@compsoc.man.ac.uk.suse.lists.linux.kernel> <p73r8fjsgl8.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r8fjsgl8.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 02:43:47PM +0200, Andi Kleen wrote:

> wouldn't an on stack buffer do nicely to format a single number ? 

Yes, this was a lazy adaption of other code. Will fix.

> it doesn't length limit count before passing to kmalloc - hole.
> Also has overflow bugs (consider someone passing 0xffffffff-1). 

Thanks.

> The sys_lookup_dcookie call looks like a security hole to me. After

I'll make it CAP_SYS_ADMIN ?

> Adding a list_head to task_struct looks quite ugly to me. Is there
> surely no better way ? e.g. you could just put it in a file private
> structure and the daemon keeps the file open.

Well, if I'm going to "hard code" the unregister I can just remove the
registration and let the oprofile code call dcookie_init/exit on event
buffer open/release.

thanks
john
