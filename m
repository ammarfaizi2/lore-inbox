Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVBNXVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVBNXVq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVBNXVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:21:45 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:22173 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261239AbVBNXVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:21:44 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Greg KH <gregkh@suse.de>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
X-Message-Flag: Warning: May contain useful information
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	<20050211011609.GA27176@suse.de>
	<1108354011.25912.43.camel@krustophenia.net>
	<4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	<1108422240.28902.11.camel@krustophenia.net>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 14 Feb 2005 15:21:41 -0800
In-Reply-To: <1108422240.28902.11.camel@krustophenia.net> (Lee Revell's
 message of "Mon, 14 Feb 2005 18:04:00 -0500")
Message-ID: <524qge20e2.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Feb 2005 23:21:41.0792 (UTC) FILETIME=[F0E28A00:01C512EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Lee> I don't see why so much effort goes into improving boot time
    Lee> on the kernel side when the most obvious user space problem
    Lee> is ignored.

How much of a win is it to run init scripts in parallel?  I seem to
recall seeing tests that show that it doesn't make much difference and
may even slow things down by causing more disk seeks as various things
start up at the same time and cause reads of different files to get
interleaved.

On the other hand, hotplug is an area that real profiling of real
systems booting has identified as something that can be improved, and
Greg's hotplug-ng seems to be a step towards a measurable improvement.

 - R.
