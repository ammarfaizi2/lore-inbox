Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270453AbTHQSAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270462AbTHQSAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:00:48 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26887
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270453AbTHQSAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:00:47 -0400
Date: Sun, 17 Aug 2003 11:00:46 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Timothy Miller <miller@techsource.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
Message-ID: <20030817180046.GY1027@matchmail.com>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Con Kolivas <kernel@kolivas.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <20030814070119.GN32488@holomorphy.com> <3F3BEA65.8080907@techsource.com> <200308160238.05185.kernel@kolivas.org> <3F3D2290.6070804@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3D2290.6070804@techsource.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:12:32PM -0400, Timothy Miller wrote:
> And for a higher priority, in addition to begin run before all tasks of 
> lower priority, they also get a longer timeslice?

With priority there are two values.  One that can be set from userspace (the
nice value), and one that is purely kept in the kernel (the priority value).

The interactivity estimating changes the priority value based on heuristics.

The nice value (by default zero), determines the range of priorities the
kernel will give to a task (based on its "interactivity rating").  And it is
this relativly static nice value that determines the time slice size also.
