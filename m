Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262846AbTCKHKU>; Tue, 11 Mar 2003 02:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262849AbTCKHKU>; Tue, 11 Mar 2003 02:10:20 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:24136
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262846AbTCKHKT>; Tue, 11 Mar 2003 02:10:19 -0500
Date: Tue, 11 Mar 2003 02:17:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1
In-Reply-To: <20030311042457.GL465@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0303110213390.29169-100000@montezuma.mastecende.com>
References: <20030311042457.GL465@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003, William Lee Irwin III wrote:

> Enable NUMA-Q's to run with more than 32 cpus by introducing a bitmap
> ADT and using it for cpu bitmasks on i386. Only good for up to 60 cpus;
> 64x requires support for node-local cluster ID to physical node routes.
> 
> Merged Randy Dunlap's cleanups last release; nothing's changed since.

Have you had an opportunity to test this code yet? If you can't get that 
large a 32bit SMP box, you could fire off some 'extra' cpus on i386 then 
fail them during boot around cpu_up, making sure to put the failed cpus 
somewhere in the middle of your cpu map so that not only do you get a 
sparse map but some on the other side of 32.

	Zwane
-- 
function.linuxpower.ca
