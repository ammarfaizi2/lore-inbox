Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269778AbUHZWnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269778AbUHZWnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269686AbUHZWjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:39:02 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:31684 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269685AbUHZWgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:36:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm1
Date: Fri, 27 Aug 2004 00:46:36 +0200
User-Agent: KMail/1.5
References: <20040826014745.225d7a2c.akpm@osdl.org>
In-Reply-To: <20040826014745.225d7a2c.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408270046.36419.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 of August 2004 10:47, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6
>.9-rc1-mm1/
>
>
> - nicksched is still here.  There has been very little feedback, except
> that it seems to slow some workloads on NUMA.
>

It has the problem that I have reported for 2.6.8.1-mm4, that after issuing:

# rmmod snd_seq_oss

the kernel goes into a strange state:
- one CPU (either CPU0 or CPU1) is 100% loaded with system load
- the other CPU is free
- the process "rmmod snd_seq_oss" is in the D+ state
- when I exit KDE session the system hangs solid (no way to get to it, reset 
necessary).
- when I try this from a virtual terminal, it freezes the keyboard and I can't 
get to the other virtual terminals/X, but I can get to the system via ssh.

No Oops is reported, and it does not happen on 2.6.8.1-mm2.

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
