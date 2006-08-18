Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWHRSBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWHRSBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHRSBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:01:20 -0400
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:20704 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S1751453AbWHRSBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:01:19 -0400
Message-ID: <44E6006C.2030406@tremplin-utc.net>
Date: Fri, 18 Aug 2006 20:01:16 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060804)
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: mplayer-users@mplayerhq.hu, linux-kernel@vger.kernel.org
Subject: Re: mplayer + heavy io: why ionice doesn't help?
References: <200608181937.25295.vda.linux@googlemail.com>
In-Reply-To: <200608181937.25295.vda.linux@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08/18/2006 07:37 PM, Denis Vlasenko wrote/a écrit:
> Hi,
> 
> I noticed that mplayer's video playback starts to skip
> if I do some serious copying or grepping on the disk
> with movie being played from.
> 
> nice helps, but does not eliminate the problem.
> I guessed that this is a problem with mplayer
> failing to read next portion of input data in time,
> so I used Jens's ionice.c from
> Documentation/block/ioprio.txt
> 
> I am using it this:
> 
> ionice -c1 -n0 -p<mplayer pid>
> 
> but so far I don't see any effect from using it.
> mplayer still skips.
> 
> Does anybody have an experience in this?
Hello

IOnice only works with CFQ, have you checked that you are using the CFQ 
IO scheduler?
# cat /sys/block/hda/queue/scheduler   #put the name of YOUR harddisk

In case it's not the default IO scheduler, you can change it with:
# echo cfq > /sys/block/hda/queue/scheduler


My two cents...
See you,
Eric


