Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270886AbTGVVa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270889AbTGVVa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:30:56 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42001
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270886AbTGVVax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:30:53 -0400
Date: Tue, 22 Jul 2003 14:45:57 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: different behaviour with badblocks on 2.6.0-test1-mm1-07int
Message-ID: <20030722214557.GE1176@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030722214253.GD1176@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722214253.GD1176@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 02:42:53PM -0700, Mike Fedyk wrote:
> Hi,
> 
> I was testing a hard drive with badblocks (from the e2fsprogs-1.34) on the
> 2.6.0-test1-mm1-07int (with Con's scheduler patch), and I noticed in vmstat
> and gkrellm that during the write passes there are reads on the same drive
> when there should only be writes.
> 
> I tried stracing badblocks, but all it showed was write() calls, and vmstat
> and gkrellm showed reads only, so it modified the behaviour.
> 
> Has anyone else seen this?
> 
> ii  e2fsprogs             1.33+1.34-WIP-2003.05 The EXT2 file system
> utilities and libraries                  
> 

Oh, and testing with the same hardware and userspace on 2.4.22-pre7 shows
normal behaviour (writes with no reading, reads with no writing).

This is with "badblocks -wso /tmp/hde.out /dev/hde > /dev/hde.log 2>&1 &" on
a bash prompt on both kernels.

Neither found any bad blocks, and /tmp is on a /dev/hda1
