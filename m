Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263820AbTCVVPF>; Sat, 22 Mar 2003 16:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263833AbTCVVPF>; Sat, 22 Mar 2003 16:15:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:7659 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263820AbTCVVPE>;
	Sat, 22 Mar 2003 16:15:04 -0500
Date: Sat, 22 Mar 2003 13:25:51 -0800
From: Andrew Morton <akpm@digeo.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65 interactivity
Message-Id: <20030322132551.75ff8ab8.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.51.0303221929350.28558@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0303221929350.28558@dns.toxicfilms.tv>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2003 21:25:51.0996 (UTC) FILETIME=[9D6393C0:01C2F0B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
>
> Hello,
> 
> I am experiencing dramatic interactivity degradation when
> apt-get upgrade is setting up the packages under X, with X running with
> nice 0 (it previously had -10)
> 
> x-terminal-emualtor windows stop getting refreshed, xmms stops playing,
> and after a few seconds everything stops responding and gets going after
> another few seconds.
> 

First thing we need to work out is whether it is a CPU scheduler thing
or if it is a VM/MM/block/fs latency problem.

- How much memory do you have?

- Are your disks runnning in DMA mode? (run hdparm /dev/hda)

- Send `vmstat 1' traces from when the problem is happening.

- If you nice up the X server, does that help?

- Try setting /proc/sys/vm/swappiness to zero

- Try decreasing /proc/sys/vm/dirty_ratio to 15
