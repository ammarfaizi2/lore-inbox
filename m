Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbRFZC1K>; Mon, 25 Jun 2001 22:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264879AbRFZC1A>; Mon, 25 Jun 2001 22:27:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41993 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264857AbRFZC0y>; Mon, 25 Jun 2001 22:26:54 -0400
Date: Mon, 25 Jun 2001 21:53:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: John Fremlin <vii@users.sourceforge.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM tuning through fault trace gathering [with actual code]
In-Reply-To: <m2d77s4m34.fsf@boreas.yi.org.>
Message-ID: <Pine.LNX.4.21.0106252152580.941-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 Jun 2001, John Fremlin wrote:

> 
> Last year I had the idea of tracing the memory accesses of the system
> to improve the VM - the traces could be used to test algorithms in
> userspace. The difficulty is of course making all memory accesses
> fault without destroying system performance.
> 
> The following patch (i386 only) will dump all page faults to
> /dev/biglog (you need devfs for this node to appear). If you echo 1 >
> /proc/sys/vm/trace then *almost all* userspace memory accesses will
> take a soft fault. Note that this is a bit suicidal at the moment
> because of the staggeringly inefficient way its implemented, on my box
> (K6-2 300MHz) only processes which do very little (e.g. /usr/bin/yes)
> running at highest priority are able to print anything to the console.
> 
> I think the best way would be to have only one valid l2 pte per
> process. I'll have a go at doing that in a day or two unless someone
> has a better idea?

Linux Trace Toolkit (http://www.opersys.com/LTT) does that. 

