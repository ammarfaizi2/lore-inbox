Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTESPBC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 11:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTESPBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 11:01:02 -0400
Received: from almesberger.net ([63.105.73.239]:13321 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262498AbTESPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 11:01:00 -0400
Date: Mon, 19 May 2003 12:13:31 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-cleanup-2.5.69-A0
Message-ID: <20030519121331.C1475@almesberger.net>
References: <Pine.LNX.4.44.0305191024320.4241-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305191024320.4241-100000@localhost.localdomain>; from mingo@elte.hu on Mon, May 19, 2003 at 10:25:44AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> the attached scheduler cleanup (against BK-curr) removes the unused
> requeueing code. Compiles & boots.

Ah, what a sweet way of getting rid of my nemesis :-)

The requeuing code troubled me quite a bit with umlsim, which
makes all kinds of calls from the idle task, including calls to
try_to_wake_up, or functions that eventually call it. Naturally,
whenever the requeuing was used, it tripped over current->array.
(And even with a fake array, it would have had ill effects.)

So the requeuing didn't do anything for processes other than the
idle task ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
