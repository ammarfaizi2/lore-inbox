Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbTJCAZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 20:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbTJCAZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 20:25:49 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52486
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263557AbTJCAZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 20:25:47 -0400
Date: Thu, 2 Oct 2003 17:26:08 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dave O <cxreg@pobox.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-hfsplus-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
Message-ID: <20031003002608.GC13051@matchmail.com>
Mail-Followup-To: Dave O <cxreg@pobox.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	linux-hfsplus-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv> <Pine.LNX.4.58.0310021300220.31213@narbuckle.genericorp.net> <Pine.LNX.4.44.0310022028220.8124-100000@serv> <Pine.LNX.4.58.0310021359140.31213@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310021359140.31213@narbuckle.genericorp.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 02:00:25PM -0500, Dave O wrote:
> This works, however du(1) seems to get the block size wrong:
> 
> meatloop:/cdrom# ls -l
> total 393244
> -rwxr-xr-x    1 501      dialout  341952833 Sep 22 17:24 else.zip
> -rwxr-xr-x    1 501      dialout  450701627 Sep 22 20:07 outlook.zip
> -rwxr-xr-x    1 501      dialout  607534655 Sep 22 17:26 quick1.zip
> -rwxr-xr-x    1 501      dialout  431279243 Sep 22 17:26 quick2.zip
> -rwxr-xr-x    1 501      dialout  605501959 Sep 22 17:27 quick3.zip
> -rwxr-xr-x    1 501      dialout  403836898 Sep 22 17:28 quick4.zip
> -rwxr-xr-x    1 501      dialout  380636073 Sep 22 17:28 quick5.zip
> 
> meatloop:/cdrom# du -sh
> 385M    .

Are you sure?  I haven't done the math, but you are comparing base 1000 to
base 1024 numbers.  Try comparing:

du -sh .
ls -lh
