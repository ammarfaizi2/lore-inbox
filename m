Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWDFGbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWDFGbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 02:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWDFGbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 02:31:35 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:58375 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751135AbWDFGbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 02:31:35 -0400
Date: Thu, 6 Apr 2006 08:31:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix unneeded rebuilds in drivers/media/video after moving source tree
Message-ID: <20060406063125.GA24352@mars.ravnborg.org>
References: <442BC74B.7060305@gmx.net> <20060330202208.GA14016@mars.ravnborg.org> <442C4469.1040408@gmx.net> <20060331152226.GB8992@mars.ravnborg.org> <4431A338.3000709@gmx.net> <20060404150233.GA10608@mars.ravnborg.org> <44345391.4000704@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44345391.4000704@gmx.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 01:32:33AM +0200, Carl-Daniel Hailfinger wrote:
> 
> Thanks. Was it intentional to leave the line below in
> drivers/media/video/bt8xx/Makefile?
> 
> EXTRA_CFLAGS += -I$(src)/..
> 
> I think it could be replaced with
> 
> EXTRA_CFLAGS += -Idrivers/media/video
> 
> but I'm not a kbuild expert.

That's a functionality equivalent - yes.
Since it was not a bug-fix I left it as is.
One day I will sweep through all of the kernel Makefiles and get rid of
the relative paths. But thats not -rc fodder.

	Sam
