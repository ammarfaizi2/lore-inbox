Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUG2AMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUG2AMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267369AbUG2AJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:09:51 -0400
Received: from holomorphy.com ([207.189.100.168]:1424 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267371AbUG2AI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:08:57 -0400
Date: Wed, 28 Jul 2004 17:08:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Eduard Bloch <blade@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: memory not released after using cdrecord/cdrdao (was: audio cd writing causes massive swap and crash)
Message-ID: <20040729000855.GI2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Eduard Bloch <blade@debian.org>, linux-kernel@vger.kernel.org
References: <20040725094605.GA18324@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040725094605.GA18324@zombie.inka.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ed Sweetman [Sat, Jul 17 2004, 04:00:13PM]:
>> Both with 2.6.7-rc3 and 2.6.8-rc1-mm1 I get the same behavior when 
>> writing an audio cd on my plextor px-712a.  DMA is enabled and normal 
>> data cds write as expected, but audio cds will cause (at any speed) the 
>> box to start using insane amounts of swap (>150MB) and eventually cause 

On Sun, Jul 25, 2004 at 11:46:05AM +0200, Eduard Bloch wrote:
> Just FYI: we have a similar bug description in the Debian BTS, where the
> user reports that kernel does not release memory assigned to userspace
> after cdrdao or cdrecord have used it (writting in DAO mode), though he
> could not find what allocated this memory. For details:
> http://bugs.debian.org/256871 (dump attached).

Is there any way we could get a characterization of the kind of memory
that's proliferating here? e.g. could you snapshot /proc/meminfo,
/proc/slabinfo, and /proc/vmstat at regular intervals during the run?


-- wli
