Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271108AbTHCHsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbTHCHsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:48:52 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:62849 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S271108AbTHCHsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:48:41 -0400
Date: Sun, 3 Aug 2003 11:45:28 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Harald Dunkel <harri@synopsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: crash in reiserfs at shutdown
Message-ID: <20030803074528.GA14013@linuxhacker.ru>
References: <3F2B9823.7010503@Synopsys.COM> <200308030649.h736nbcj013727@car.linuxhacker.ru> <3F2CBD0C.4040603@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2CBD0C.4040603@Synopsys.COM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Aug 03, 2003 at 09:43:08AM +0200, Harald Dunkel wrote:
> >HD> Final words are
> >HD>         kernel BUG at fs/reiserfs/prints.c: 339
> >There should be one line prior to that.
> >This line explains what went wrong in reiserfs opinion.
> >Can you please say us what was the line?
> It said
> 	unmounting local filesystems... bio too big device sdc1 (8 > 0)
> 	bio too big device sdc1 (8 > 0)
> 	journal - 601, buffer write failed

Ok, so it tried to write the journal stuff and failed.

> To me the problem seems that the USB stuff is shutdown
> without unmounting the external USB disk first. Later, at
> the "unmounting all disks" step in the shutdown procedure
> the USB storage device can't be accessed anymore.

Yes, this really seems to be a problem.
Reiserfs is really unhappy when media disappear under its feet.

Bye,
    Oleg
