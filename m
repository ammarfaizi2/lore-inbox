Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263659AbTHZNF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 09:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbTHZNF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 09:05:26 -0400
Received: from gate.perex.cz ([194.212.165.105]:63501 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S263689AbTHZNFW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 09:05:22 -0400
Date: Tue, 26 Aug 2003 15:03:51 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Strange memory usage reporting
In-Reply-To: <yw1xad9w1uj5.fsf@users.sourceforge.net>
Message-ID: <Pine.LNX.4.44.0308261459180.29234-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, [iso-8859-1] Måns Rullgård wrote:

> I was a little surprised to see top tell me this:
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND           
> 10642 mru       11   0 23200  81m 2740 S  0.0 37.0   0:00.07 tcvp              
> 
> It didn't make sense that RES > VIRT, so I check /proc/pid/*.  Their
> contents are below.  Am I missing something?  Note that they are not
> consistent with the 'top' line above, since they were copied at a
> different time.  The effect is easily reproducible.  It happens every
> time I run my music player with using ALSA.

I have exactly same behaviour with 2.4.21 kernel. It seems that VmRSS
grows with the mmap2 syscalls although appropriate munmap is called. I'm
investigating a possible problem with the memory accounting.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

