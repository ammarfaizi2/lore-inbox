Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVCYGqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVCYGqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCYGqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:46:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:13472 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261454AbVCYGqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 01:46:14 -0500
Date: Thu, 24 Mar 2005 22:05:34 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>, Laurent Riffard <laurent.riffard@free.fr>,
       rjw@sisk.pl, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2
Message-ID: <20050325060534.GA8432@kroah.com>
References: <20050324044114.5aa5b166.akpm@osdl.org> <1111682812.23440.6.camel@mindpipe> <20050324121722.759610f4.akpm@osdl.org> <200503242331.46985.rjw@sisk.pl> <42434E59.2060805@free.fr> <20050324154920.4e506d76.akpm@osdl.org> <Pine.LNX.4.50.0503241658360.29178-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0503241658360.29178-100000@monsoon.he.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 05:00:18PM -0800, Patrick Mochel wrote:
> 
> On Thu, 24 Mar 2005, Andrew Morton wrote:
> 
> > Laurent Riffard <laurent.riffard@free.fr> wrote:
> > >
> > > hello,
> > >
> > > Same kinds of problem here. It depends on the removed module. I mean:
> > > "rmmod loop" or "rmmod pcspkr" works. But "rmmod snd_ens1371" or "rmmod
> > > ohci1394" hangs.
> > >
> > > Sysrq-T when rmmoding snd_ens1371 :
> 
> <snip>
> 
> > It looks like we're getting stuck in the wait_for_completion() in the new
> > klist_remove().
> 
> D'oh! It's getting hung while waiting to remove the current node from the
> list (which it can't remove because it's being used). The patch below
> should fix it.

Thanks, I've added this to my bk trees.

greg k-h
