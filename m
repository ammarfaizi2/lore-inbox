Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUJCUMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUJCUMy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUJCUMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:12:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5520 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268117AbUJCUMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:12:53 -0400
Date: Sat, 2 Oct 2004 16:24:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: EXT3-fs errors after going into S1
Message-ID: <20041002142425.GA3089@openzaurus.ucw.cz>
References: <1096646879.636.27.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096646879.636.27.camel@boxen>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I was playing a bit with suspend on 2.6.9-rc3 (latest -bk tree) and noticed this.
> I run the script below and do "echo -n 1 > /proc/acpi/sleep" maybe 2-3 times and
> after that ext3 sends some stuff on my console.
> Reproducible, happens with & without preempt. UP box running debian, no highmem.
> 
> #!/bin/sh
> for i in 0 1 2 3 4 5 6 7 8 9
> do
> 	find / &> /dev/null &
> done
> 
> I also did a _fsck.ext3 -f -c /dev/hda9_ to make sure there were no bad sectors.
> 

S1 should be really simple. Try removing actual entering of S1 in hwsleep.c,
and see if it goes away.

If it does you probably have hw problem.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

