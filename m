Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVE0OEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVE0OEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVE0OEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:04:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:20178 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261751AbVE0OBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:01:51 -0400
Subject: Re: weird X problem - priority inversion?
From: Lee Revell <rlrevell@joe-job.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505230110240.7165@qynat.qvtvafvgr.pbz>
References: <1113428938.16635.13.camel@mindpipe>
	 <20050523075508.GC9287@elte.hu>
	 <Pine.LNX.4.62.0505230110240.7165@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Date: Fri, 27 May 2005 10:01:50 -0400
Message-Id: <1117202510.13829.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 01:11 -0700, David Lang wrote:
> remember that the low pri screensaver is just generating the image to be 
> displayed, it's the high pri X server that's actually doing the work to 
> display it.

Then there needs to be some mechanism to handle it, either in X or the
kernel.  Other OSes do not require you to turn off the screensaver to
avoid a DoS - they do the obvious thing and run the screensaver at the
lowest priority.

The problem may be software 3D rendering (I did not have the VIA driver
enabled as I did not realize it was in the kernel yet).   Maybe the X
server should do the work in a low priority thread.  But it sure
shouldn't DoS the system.  Other OSes do not have this problem.

Lee

