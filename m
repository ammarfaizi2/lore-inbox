Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbTBQOcN>; Mon, 17 Feb 2003 09:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbTBQObI>; Mon, 17 Feb 2003 09:31:08 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:30415
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267124AbTBQOaF>; Mon, 17 Feb 2003 09:30:05 -0500
Date: Mon, 17 Feb 2003 09:38:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Don't wake up tasks on offline processors
In-Reply-To: <Pine.LNX.4.44.0302171530060.24755-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0302170933150.18087-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0302171530060.24755-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Ingo Molnar wrote:

> 
> On Mon, 17 Feb 2003, Zwane Mwaikambo wrote:
> 
> > This is the current code to migrate tasks off a dead cpu;
> 
> looks good in principle, but to avoid races i'd rather suggest to lock
> _all_ runqueues in one big swoop, and then just move everything as
> apropriate. It's not like this code has to be highly effective.

Ok i'll have a go at that instead, however how hard would it be to do a 
multiple lock acquisition of that magnitude on 16+ cpus?

Thanks,
	Zwane
-- 
function.linuxpower.ca
