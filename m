Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269237AbUISMeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbUISMeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 08:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269238AbUISMeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 08:34:05 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:50925 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269237AbUISMeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 08:34:01 -0400
Subject: Re: nproc: So?
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040919103951.GA17132@k3.hellgate.ch>
References: <1095440131.3874.4626.camel@cube>
	 <20040917175130.GA7050@k3.hellgate.ch> <1095511212.4973.8.camel@cube>
	 <20040919103951.GA17132@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1095596996.4974.27.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Sep 2004 08:29:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-19 at 06:39, Roger Luethi wrote:
> On Sat, 18 Sep 2004 08:40:12 -0400, Albert Cahalan wrote:
> > To me, this looks like the killer feature. You could even
> > skip the regular process info. Simply return process identification
> > cookies that could be passed into a separate syscall to get
> > the information.
> 
> Do you mean "return cookies for all existing processes"? Or "return
> cookies for all processes created since X" (if so, what's X?) ?

First, queue cookies for all existing processes.
Then, as process data changes, queue cookies for
processes that need to be examined again. Suppress
queueing of cookies for processes that are already
in the queue so things don't get too backed up.
If memory usage exceeds some adjustable limit, then
switch to supplying all processes until the backlog
is gone.

I realize that the implementation may prove difficult.

> With nproc as-is you can send a request that matches your desired struct
> and cast the result to a pointer to your struct.

Either that's marketing, or I missed something. :-)

Can I force specific data sizes? Can I force a string to
be NUL-terminated or a NUL-padded fixed-length buffer?
Can I request padding bytes to be skipped over?


