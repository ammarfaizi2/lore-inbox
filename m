Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbTBQOXL>; Mon, 17 Feb 2003 09:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTBQOWI>; Mon, 17 Feb 2003 09:22:08 -0500
Received: from mx1.elte.hu ([157.181.1.137]:37352 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267426AbTBQOVz>;
	Mon, 17 Feb 2003 09:21:55 -0500
Date: Mon, 17 Feb 2003 15:30:59 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Don't wake up tasks on offline processors
In-Reply-To: <Pine.LNX.4.50.0302170924250.18087-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0302171530060.24755-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Feb 2003, Zwane Mwaikambo wrote:

> This is the current code to migrate tasks off a dead cpu;

looks good in principle, but to avoid races i'd rather suggest to lock
_all_ runqueues in one big swoop, and then just move everything as
apropriate. It's not like this code has to be highly effective.

	Ingo

