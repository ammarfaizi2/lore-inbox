Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262267AbRETXdB>; Sun, 20 May 2001 19:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbRETXcw>; Sun, 20 May 2001 19:32:52 -0400
Received: from chiara.elte.hu ([157.181.150.200]:14607 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262267AbRETXcm>;
	Sun, 20 May 2001 19:32:42 -0400
Date: Mon, 21 May 2001 01:31:01 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: "Robert M. Love" <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: sqrt in kernel?
In-Reply-To: <20010521003308.R5947@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.33.0105210129540.1569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 May 2001, Matti Aarnio wrote:

> 	In some cases even the fast-paths carry FP/MMX code,
> 	but those are cases where the save/restore overhead
> 	becomes negligible for all of the other processing
> 	that is going on.

even in that case you must make sure you dont raise any FP exceptions,
which could change the non-CPU based FPU context of the process.

	Ingo

