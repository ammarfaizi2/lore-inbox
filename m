Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbSJWCWo>; Tue, 22 Oct 2002 22:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSJWCWo>; Tue, 22 Oct 2002 22:22:44 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:26893 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262788AbSJWCWn>; Tue, 22 Oct 2002 22:22:43 -0400
Date: Tue, 22 Oct 2002 22:28:52 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status
Message-ID: <20021023022852.GK536@phunnypharm.org>
References: <Pine.LNX.4.44.0210222038380.8594-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210222038380.8594-100000@dad.molina>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --------------------------------------------------------------------------
>    open                   21 Oct 2002 oops in ieee1394
>   74. http://marc.theaimsgroup.com/?l=linux-kernel&m=103519819428268&w=2
> 
> --------------------------------------------------------------------------

Oh this is a real ass biter.

I have a workqueue that I setup once. Same data, same function, it never
changes. Every so often I call schedule_work() for the task.

Is queue_task() not reentrant? IOW, can I not schedule work that was
already scheduled similar to how tasklets worked?

Also, after the task has been run, does the workqueue struct's list
member not get cleared?

I'm a bit confused by this, as I expected behavior similar to before.


Ben

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
