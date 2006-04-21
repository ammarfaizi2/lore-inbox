Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWDUU4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWDUU4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWDUU4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:56:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:63237 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932458AbWDUU4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:56:46 -0400
Date: Fri, 21 Apr 2006 22:56:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Adrian Bunk <bunk@stusta.de>, Steven Whitehouse <swhiteho@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
Message-ID: <20060421205639.GA26949@mars.ravnborg.org>
References: <1145636558.3856.118.camel@quoit.chygwyn.com> <20060421164309.GE19754@stusta.de> <20060421164910.GV24104@parisc-linux.org> <20060421165351.GG19754@stusta.de> <20060421170753.GW24104@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421170753.GW24104@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 11:07:53AM -0600, Matthew Wilcox wrote:
> On Fri, Apr 21, 2006 at 06:53:51PM +0200, Adrian Bunk wrote:
> > On Fri, Apr 21, 2006 at 10:49:10AM -0600, Matthew Wilcox wrote:
> > > On Fri, Apr 21, 2006 at 06:43:09PM +0200, Adrian Bunk wrote:
> > > > - "depends on SYSFS" instead of the select
> > > 
> > > Why?  It's more natural to select it rather than depend on it.
> > 
> > The rule of thumb is that an option is either user visible and should be 
> > depended on or not user visible and should be select'ed.
> 
> What rubbish!  Who came up with this rule of thumb?
Currently menuconfig makes it a very difficult job to undo a select.
Homework: try to do "make allmodconfig" and then set CONFIG_HOTPLUG=n

You will be hit by CONFIG_FW_LOADER that is 'selected' by many
instances - and then it becomes very difficult.
So until menuconfig has better support for undoing select the rule of
thumb outlined by Adrian is true.

	Sam
