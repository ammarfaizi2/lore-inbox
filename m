Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262229AbTC1GRb>; Fri, 28 Mar 2003 01:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbTC1GRb>; Fri, 28 Mar 2003 01:17:31 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:57086
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262229AbTC1GRa>; Fri, 28 Mar 2003 01:17:30 -0500
Date: Fri, 28 Mar 2003 01:25:01 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: task_struct slab cache use after free in 2.5.66
In-Reply-To: <3E83EAC3.3080107@colorfullife.com>
Message-ID: <Pine.LNX.4.50.0303280124210.2884-100000@montezuma.mastecende.com>
References: <3E83EAC3.3080107@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Manfred Spraul wrote:

> I didn't send a patch. One thing I noticed from reading zwane's bug 
> report is that the reference count of the task structure was off by at 
> least 3:
> 
> 	__detach_pid(p, PIDTYPE_PGID)
> 
> failed because the task structure was already filled with slab poison.

Ok i'm going to give Andrew's debug patch a go.

-- 
function.linuxpower.ca
