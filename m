Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290246AbSAOXyr>; Tue, 15 Jan 2002 18:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290241AbSAOXxX>; Tue, 15 Jan 2002 18:53:23 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37040 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290267AbSAOXvp>;
	Tue, 15 Jan 2002 18:51:45 -0500
Date: Wed, 16 Jan 2002 02:49:09 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
In-Reply-To: <20020115234814.DB1E729905@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33.0201160247530.27739-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Ed Tomlinson wrote:

> The 2.4.17-I0 patch makes things much better here.  Does this one
> suffer from the same bugs that the 2.5.2 version has?

i'll do a -I3 patch in a minute.

> Major difference from older version of the patch is that top shows
> many processes with PRI 0.  I am not sure this is intended?

yes, it's intended. Lots of interactive (idle) tasks. Right now the time
under which we detect a task as interactive is pretty short, but if you
run 'top' with 's 0.3' then you can see how tasks grow/shrink their
priorities, depending on the load they generate.

	Ingo

