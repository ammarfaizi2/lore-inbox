Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316959AbSGSUt3>; Fri, 19 Jul 2002 16:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSGSUt3>; Fri, 19 Jul 2002 16:49:29 -0400
Received: from [208.48.139.185] ([208.48.139.185]:26512 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S316959AbSGSUt2>; Fri, 19 Jul 2002 16:49:28 -0400
Date: Fri, 19 Jul 2002 13:52:25 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
Message-ID: <20020719135225.A4048@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
References: <20020719163350.D28941@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020719163350.D28941@sventech.com>; from johannes@erdfelt.com on Fri, Jul 19, 2002 at 04:33:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 04:33:50PM -0400, Johannes Erdfelt wrote:
> I recently upgraded a web server I run to a the 2.4.19rc2aa1 kernel to
> see how much better the VM is.
> 
> It seems to be better than the older 2.4 kernels used on this machine,
> but there seems to be lots of motion in the cache for all of the free
> memory that exists:
> 
>    procs                      memory    swap          io     system  cpu
>  3  0  0 106036 502288  10812  67236   0   0     0     0  802   494  46  37  17
>  5  0  2 106032 476188  10844  91496   0   0     4   316  905   573  54  37   8
> 16  0  2 106032 355400  10844 203880   0   0     4     0  909   540  51  49   0
> 10  0  2 106024 340108  10852 221548   0   0    28     0  975   659  36  64   0
>  0  0  0 106024 528340  10852  43572   0   0     4     0  569   426  17  17  67
>  0  1  0 106024 531304  10852  43612   0   0     4     0  542   342   9  14  77
>
> This is with a 1 second interval. Why is it that most of the time I have
> ~400MB of memory free (this machine has 1GB of memory). Why does the
> cache size vary so wildly?
> 
> This machine is busy, as you can see, but it looks like the VM is trying
> to be a bit too aggressive here.

What type of workload?  This looks fairly typicaly of a workload which
writes/deletes large files.

-Dave
