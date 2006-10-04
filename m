Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbWJDLYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbWJDLYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030821AbWJDLYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:24:52 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:742 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1030542AbWJDLYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:24:52 -0400
Date: Wed, 4 Oct 2006 13:24:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: another attempt to kill off linux/config.h
Message-ID: <20061004112450.GA6858@uranus.ravnborg.org>
References: <20061004074434.GA13672@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004074434.GA13672@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 03:44:34AM -0400, Dave Jones wrote:
> Every time I (or someone else) gets a patch included
> removing explicit includes of linux/config.h, another few creep
> into the tree a day or so later.
> 
> Lets kill them all for good.
> 
> master.kernel.org:/pub/scm/linux/kernel/git/davej/configh.git
> 
> is a git tree killing off all the current users in tree,
> and adds a #warn to include/linux/config.h that it's going away.
> (This should still leave as-yet-unmerged trees compiling,
>  and hopefully get them fixed before they get merged)
> We can then remove the file for real just before 2.6.19

Removing it for real will be a pain for external modules.
They could of course detect that it is missing and then
drop it.
I would suggest to keep the #warning in 2.6.19 and only
remove it for real for 2.6.20.

	Sam
