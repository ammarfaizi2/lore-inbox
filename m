Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbTBOWce>; Sat, 15 Feb 2003 17:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbTBOWce>; Sat, 15 Feb 2003 17:32:34 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:53572
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265368AbTBOWcd>; Sat, 15 Feb 2003 17:32:33 -0500
Date: Sat, 15 Feb 2003 17:39:01 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
In-Reply-To: <200302152207.XAA09202@faui11.informatik.uni-erlangen.de>
Message-ID: <Pine.LNX.4.50.0302151734280.16012-100000@montezuma.mastecende.com>
References: <200302152207.XAA09202@faui11.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Ulrich Weigand wrote:

> I'm not sure I understand what you mean here.  In any case, at least
> on S/390, doing a SIGP to an invalid CPU will simply get you an
> 'not operational' indication (condition code 3), so in fact the
> only problem *is* the busy loop on num_cpus ...

On other architectures it can get nasty if you send an interprocessor 
interrupt out onto the bus for an invalid cpu destination. 
Since not having the online map will be a problem for you I'll add the 
mask = ... & cpu_online_map to cover the concerns you have.

Thanks,
	Zwane
-- 
function.linuxpower.ca
