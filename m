Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTELHVJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTELHVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 03:21:09 -0400
Received: from almesberger.net ([63.105.73.239]:63247 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261969AbTELHVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 03:21:08 -0400
Date: Mon, 12 May 2003 04:33:43 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anyone ever implemented a reparent(pid) syscall?
Message-ID: <20030512043343.A1861@almesberger.net>
References: <3EBBF965.4060001@nortelnetworks.com> <20030510063936.D13069@almesberger.net> <3EBF1398.9090704@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBF1398.9090704@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Sun, May 11, 2003 at 11:23:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Sure. So the monitorer starts up, attempts to watch a pid, gets an error
> saying that it doesn't exist, and handles it.

You'd still have a PID reuse race. Of course, you could also
cover this by checking the process' start time ...

But just designing the parent to be simple enough to be reliable
and/or generic enough that it doesn't even need to be upgraded
still looks like a more promising approach to me.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
