Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbTBPCkA>; Sat, 15 Feb 2003 21:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTBPCkA>; Sat, 15 Feb 2003 21:40:00 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:11339
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265643AbTBPCkA>; Sat, 15 Feb 2003 21:40:00 -0500
Date: Sat, 15 Feb 2003 21:48:20 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <67320000.1045361394@[10.10.2.4]>
Message-ID: <Pine.LNX.4.50.0302152147390.16012-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0302151723560.23951-100000@home.transmeta.com>
 <67320000.1045361394@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Martin J. Bligh wrote:

> -	struct mm_struct *mm = get_task_mm(task);
> +	struct mm_struct *mm;
>  
> +	task_lock(task);
> +	mm = __get_task_mm(task);
>  	buffer = task_name(task, buffer);
>  	buffer = task_state(task, buffer);

task_state acquires the task_struct lock.

	Zwane
-- 
function.linuxpower.ca
