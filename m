Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbUBPUpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUBPUpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:45:51 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:51334 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265821AbUBPUpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:45:49 -0500
Date: Mon, 16 Feb 2004 22:01:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Davis <tadavis@lbl.gov>, Andrew Morton <akpm@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix make rpm in 2.6 when using RH9 or Fedora..
Message-ID: <20040216210121.GD2977@mars.ravnborg.org>
Mail-Followup-To: Thomas Davis <tadavis@lbl.gov>,
	Andrew Morton <akpm@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <402BD507.2040201@lbl.gov> <402EE151.4000807@tmr.com> <403008C0.1070806@lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403008C0.1070806@lbl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 04:03:12PM -0800, Thomas Davis wrote:
> Bill Davidsen wrote:
> >
> >
> >Why do you want to disable the missing file check? As opposed to 
> >providing the file?
> >
> >I personally fix ther problem instead of disabling the check, the list 
> >can be empty, of course.

There is enough files that needs to be cleaned up after a build, no reason to
add more of them.

> >
> 
> There is four options to fix this problem.
> 
> 1) Change the RH9/Fedora macros.
> 2) Add a global entry into my .rpmmacros
> 3) Find and create the missing file (empty, in this case) (ie, do a 'touch 
> /usr/src/linux-2.6.3/debugfiles.list' and it will proceed without making 
> the debugfile RPM.)
> 4) Disable it in the specfile, since only RH9/Fedora does this, and 
> Mandrake/SuSE probably doesn't.
> 
> I'm not going to do #1, and I'm not going to do #2, I'll settle for #3 or 
> #4, but #3 now means another file to ship around or create, even if it's 
> empty.

Since this is a fedora/RH9 issue go for option #4. If we need this file in the
future we will add it.
Please forward the original patch to Andrew for inclusion.

	Sam
