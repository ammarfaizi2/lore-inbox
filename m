Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289145AbSANWuE>; Mon, 14 Jan 2002 17:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289140AbSANWt7>; Mon, 14 Jan 2002 17:49:59 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:17678 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S289120AbSANWtp>;
	Mon, 14 Jan 2002 17:49:45 -0500
Date: Mon, 14 Jan 2002 15:46:40 -0700
From: yodaiken@fsmlabs.com
To: Momchil Velikov <velco@fadata.bg>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver.Neukum@lrz.uni-muenchen.de,
        yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114154640.A26460@hq.fsmlabs.com>
In-Reply-To: <E16QB8b-0002K8-00@the-village.bc.nu> <87sn98ftpi.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <87sn98ftpi.fsf@fadata.bg>; from velco@fadata.bg on Tue, Jan 15, 2002 at 12:34:01AM +0200
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 12:34:01AM +0200, Momchil Velikov wrote:
> One can consider a non-preemptible kernel as a special kind of
> priority inversion, preemptible kernel will eliminate _that_ case of
> priority inversion.

The problem here is that priority means something very different in 
a time-shared system than in a hard real-time system. And even in real-time
systems, as Walpole and colleagues have pointed out, priority doesn't
really capture much of what is needed for good scheduling.

In a general purpose system,  priorities are dynamic and "fair". 
The priority of even the lowliest process increases while it waits
for time. In a raw real-time system, the low priority process can sit
forever and should wait until no higher priority thread needs the 
processor. So it's absurd to talk of priority inversion in a non RT
system. When a low priority process is delaying a higher priority task
for reasons of fairness, increased throughput, or any other valid
objective, that is not a scheduling error.


> 
> Regards,
> -velco

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

