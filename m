Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbTFFACh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 20:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbTFFACh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 20:02:37 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:30916 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265266AbTFFACg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 20:02:36 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 5 Jun 2003 17:13:55 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <20030605183408.GB3291@matchmail.com>
Message-ID: <Pine.LNX.4.55.0306051710110.4466@bigblue.dev.mcafeelabs.com>
References: <11E89240C407D311958800A0C9ACF7D1A33EBD@EXCHANGE>
 <Pine.LNX.4.55.0306041717230.3655@bigblue.dev.mcafeelabs.com>
 <20030605183408.GB3291@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003, Mike Fedyk wrote:

> On Wed, Jun 04, 2003 at 05:19:05PM -0700, Davide Libenzi wrote:
> > Besides the stupid name O_REALLYNONBLOCK, it really should be different
> > from both O_NONBLOCK and O_NDELAY. Currently in Linux they both map to the
> > same value, so you really need a new value to not break binary compatibility.
>
> Hmm, wouldn't that be source and binary compatability?  If an app used
> O_NDELAY and O_NONBLOCK interchangably, then a change to O_NDELAY would
> break source compatability too.

Oh, that's for sure.


> Also, what do other UNIX OSes do?  Do they have seperate semantics for
> O_NONBLOCK and O_NDELAY?  If so, then it would probably be better to change
> O_NDELAY to be similar and add another feature at the same time as reducing
> platform specific codeing in userspace.

If I remember it correctly, they differ from the return value that you get
from blocking-candidate functions (0 <-> -1).



- Davide

