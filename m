Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTH0LSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbTH0LSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:18:47 -0400
Received: from holomorphy.com ([66.224.33.161]:46006 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263195AbTH0LSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:18:46 -0400
Date: Wed, 27 Aug 2003 04:18:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: warudkar@vsnl.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
Message-ID: <20030827111859.GA4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	warudkar@vsnl.net, linux-kernel@vger.kernel.org
References: <200308272138.h7RLciK29987@webmail2.vsnl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308272138.h7RLciK29987@webmail2.vsnl.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 04:38:44PM -0500, warudkar@vsnl.net wrote:
> Here a snapshot of Top output when running 2.6.0-test4-mm1:
> ==============================
>   4:24pm  up 21:19,  6 users,  load average: 3.47, 2.04, 1.49
> 96 processes: 88 sleeping, 8 running, 0 zombie, 0 stopped
> CPU states: 11.3% user, 88.6% system,  0.0% nice,  0.0% idle
> Mem:   124632K av,  122664K used,    1968K free,       0K shrd,     160K buff
> Swap: 1052248K av,   71256K used,  980992K free                   43540K cached
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>     8 root      15   0     0    0     0 SW   66.6  0.0   4:59 kswapd0
>  2087 wipro     17   0 29576  10M 27408 S     4.6  8.9   0:03 kdeinit
>  2044 wipro     17   0  118M  22M  103M D     2.7 18.8   0:04 soffice.bin

This looks odd. At any rate, the 71MB swap should be a big hint you're
in for slow times. 2.4.x likely does okay here because the virtualscan
acts as implicit load control; 2.6.x will likely need explicit load
control to handle that workload on that machine.


-- wli
