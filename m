Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbSIYWJQ>; Wed, 25 Sep 2002 18:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbSIYWJQ>; Wed, 25 Sep 2002 18:09:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262100AbSIYWJO>;
	Wed, 25 Sep 2002 18:09:14 -0400
Message-Id: <200209252214.g8PMEQd06269@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Con Kolivas <conman@kolivas.net>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       cliffw@osdl.org
Subject: Re: [BENCHMARK] fork_load module tested for contest 
In-Reply-To: Message from Con Kolivas <conman@kolivas.net> 
   of "Thu, 26 Sep 2002 00:42:16 +1000." <1032964936.3d91cb48b1cca@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 25 Sep 2002 15:14:26 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> 
> I've been trialling a new load module for the contest benchmark
> (http://contest.kolivas.net) which simply forks a process that does nothing,
> waits for it to die, then repeats. Here are the results I have obtained so far:
> 
> noload:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  72.90           99%             1.00
> 2.4.19-ck7              71.55           100%            0.98
> 2.5.38                  73.86           99%             1.01
> 2.5.38-mm2              73.93           99%             1.01
> 
> fork_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  100.05          69%             1.37
> 2.4.19-ck7              74.65           95%             1.02
> 2.5.38                  77.35           95%             1.06
> 2.5.38-mm2              76.99           95%             1.06
> 
> ck7 uses O1, preempt, low latency
> Preempt=N for all other kernels
> 
> Clearly you can see the 2.5 kernels have a substantial lead over the current
> stable kernel.
> 
> This load module is not part of the contest package yet. I could certainly
> change it to fork n processes but I'm not really sure just how many n should be.

I think for OSDL/STP, it would be nice if n == number of CPU's, so maybe make 
'n' an arg?
When you say the process 'does nothing', what do you mean? It forks, then the 
child does exit() ?
cliffw
> 
> Comments?
> 
> Con Kolivas
> 
> P.S. Results have negligible differences on repeat testing.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


