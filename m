Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272345AbRIUIs1>; Fri, 21 Sep 2001 04:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272404AbRIUIsR>; Fri, 21 Sep 2001 04:48:17 -0400
Received: from gw.framfab.dk ([194.239.251.2]:2591 "HELO [194.239.251.2]")
	by vger.kernel.org with SMTP id <S272345AbRIUIsI>;
	Fri, 21 Sep 2001 04:48:08 -0400
Message-ID: <3BAAFECC.9060701@fugmann.dhs.org>
Date: Fri, 21 Sep 2001 10:48:12 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Samuel T Ting <sting@u.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Preemptive kernel and vm management in 2.4.9
In-Reply-To: <Pine.A41.4.33.0109201717570.102458-100000@dante09.u.washington.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The preemption patch helps on problems with high letencies.

High latencies means that the kernel is busy doing something, so that 
other threads will get starved. This problem is especially seen when 
using multimedia.

The most discussed problem is listening to a MP3-file, while the machine 
has a high load. What we want to avoid is skips in the music.

Tee preemption patch helps, because it allows preemption of processes 
running in kernel space, meaning that the sheduler can choose another 
process, even though the process running is in kernel-space.
(A very crude description, I know, but AFAIK is is the general idea)

Without the preemption patch, whenever a userprocess makes a call to the 
kernel, it could not be resheduled before the call had returned. This 
results in very high latencies for some kernel calls.

Hope it helps, othervice please refere to documentation and recent 
lkml-threads.

Anders Fugmann



Samuel T Ting wrote:

> Hello all,
> 
> Lately, I have been hearing a lot about preemptive kernels on the list.
> I have just started looking into kernel internals, so could somebody
> explain what kernel preemption is?
> 
> Also, how does virtual memory management in 2.4.9 work?
> 
> Thanks!
> 
> Samuel Ting
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



