Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVJXNEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVJXNEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 09:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVJXNEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 09:04:32 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:13576 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1750982AbVJXNEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 09:04:32 -0400
To: "Travis H." <solinym@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: terminal handling: collecting inter-keystroke timings
References: <d4f1333a0510232356v1778fb10s186af3979aa323db@mail.gmail.com>
	<d4f1333a0510240046s18021c3exe61ad783ddff0778@mail.gmail.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Mon, 24 Oct 2005 09:01:46 -0400
In-Reply-To: <d4f1333a0510240046s18021c3exe61ad783ddff0778@mail.gmail.com> (Travis H.'s message of "Mon, 24 Oct 2005 02:46:07 -0500")
Message-ID: <m2y84jnk5h.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Travis H." <solinym@gmail.com> writes:

> I'd like to be able to do it with (ttys attached to?) network sockets
> as well, so that I could test out the applicability of it to remote
> users.

One issue here is Nagle--you'll definitely want to turn that off, and
I don't think you can do it from the server side.  Also, I think SSH
does its own batching of keystrokes, to decrease the overhead of the
crypto encapsulation.  So this part seems like a hard problem without
a cooperating client. 

>
> Ideally any mechanism would be flexible enough that I could have it
> deliver me timings between key-down, key-up-to-key-down, or up/down to
> up/down timings.

You're not going to be able to do that with network connections, only
locally attached keyboards.

-Doug
