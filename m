Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbTGIU4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 16:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266148AbTGIU4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 16:56:18 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:28690 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S266147AbTGIU4R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 16:56:17 -0400
Date: Wed, 9 Jul 2003 16:10:55 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
Message-ID: <20030709211055.GI1031@dbz.icequake.net>
References: <20030708202819.GM1030@dbz.icequake.net> <3F0B2CE6.8060805@nni.com> <20030708212517.GO1030@dbz.icequake.net> <3F0C2FCB.8060304@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3F0C2FCB.8060304@blue-labs.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David,

On Wed, Jul 09, 2003 at 11:07:55AM -0400, David Ford wrote:
> No such thing exists.  I can have 10,000 processes doing nothing and 
> have a load average of 0.00.  I can have 100 processes each sucking cpu 
> as fast as the electrons flow and have a dead box.

Well, like I said, in this specific case we talk about a fork bomb, not
a bunch of idle processes.  My question is what the upper limit to set,
in order to ensure that processes that do nothing but "while (1)
fork();" do not take down the system.  Apparently 2047 is too high for
2.4.21, at least on my system.  But, a slower box manages a 2047 ulimit
fine with a 2.4.20 kernel.

> Learn how to manage resource limits and you can tuck another feather 
> into your fledgeling sysadmin hat ;)

I already know how to manage the limits, but I am asking why the system
seems to hang indefinitely when a maximum of 2047 is set, but not when
e.g. 1500 is set.  Do you have any idea?  Why would there be such a
large change in behavior with such a small change in parameter?

Furthermore, why does my (slower, 600 < 800mhz) system running 2.4.20
kill off a fork bomb at a 2047 ulimit instantaneously, but 2.4.21 takes
half an hour or more, at which point I give up?

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
