Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbTIZRzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbTIZRzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:55:17 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:9891 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261448AbTIZRzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:55:13 -0400
Date: Fri, 26 Sep 2003 19:53:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Michael Frank <mhf@linuxmail.org>,
       andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] SIS IDE DMA errors
Message-ID: <20030926175358.GA12072@ucw.cz>
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <200309262208.30582.mhf@linuxmail.org> <yw1x3cejlk34.fsf@users.sourceforge.net> <200309262332.30091.mhf@linuxmail.org> <20030926165957.GA11150@ucw.cz> <yw1x7k3vjw8o.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x7k3vjw8o.fsf@users.sourceforge.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 07:27:35PM +0200, M?ns Rullg?rd wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > Actually, it's me who wrote the 961 and 963 support. It works fine for
> > most people. Did you check you cabling?
> 
> I'm dealing with a laptop, but I suppose I could wiggle the cables a
> bit.  I still doubt it's a cable problem, since reading works
> flawlessly.

Hmm, that's indeed interesting and it'd point to a driver problem -
when reading, the drive is dictating the timing, but when writing, it's
the controllers turn.

So if the controller timing is not correctly programmed, reads function,
but writes don't.

Can you send me the output of 'lspci -vvxxx' of the IDE device?
I'll take a look to see if it looks correct.

> It appears to me that during heavy IO load, some DMA interrupts get
> lost, for some reason.

Well, I've got this feeling that not just IDE interrupts get lost under
heavy IO load with recent kernels ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
