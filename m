Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbUBDJmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 04:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbUBDJmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 04:42:06 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:61927 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S266101AbUBDJmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 04:42:03 -0500
Date: Wed, 04 Feb 2004 22:43:33 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: ext3 on raid5 failure
In-reply-to: <4020BA67.9020604@basmevissen.nl>
To: Bas Mevissen <ml@basmevissen.nl>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Dittmer <j.dittmer@portrix.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1075887812.2518.125.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <400A5FAA.5030504@portrix.net>
 <20040118180232.GD1748@srv-lnx2600.matchmail.com>
 <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net>
 <20040127190813.GC22933@thunk.org> <401794F4.80701@portrix.net>
 <20040129114400.GA27702@thunk.org> <4020BA67.9020604@basmevissen.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Are you using a swap partition or swap file? If we're talking swap file,
I would suspect suspend2. I haven't had a chance to look yet (preparing
to move to Aussie), but Michael has told me there are problems with the
swapfile support.

If you had a crash while using suspend and swap file support, I wouldn't
be totally surprised to see an emergency sync causing this. That said,
the code has a number of safety nets aimed at stopping us syncing while
suspend is running, to avoid precisely this sort of corruption. If it
was suspend, I'd expect your superblock to have been messed too. Did
that happen?

Regards,

Nigel

On Wed, 2004-02-04 at 22:24, Bas Mevissen wrote:
> Theodore Ts'o wrote:
> >
> >>
> >>sfhq:/mnt/data/1/lost+found# ls -l
> >>total 76
> >>d-wSr-----    2 1212680233 136929556    49152 Jun  7  2008 #16370
> >>-rwx-wx---    1 1628702729 135220664    45056 May  4  1974 #16380

