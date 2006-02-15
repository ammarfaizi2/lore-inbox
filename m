Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423005AbWBOHKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423005AbWBOHKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWBOHKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:10:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:720 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1423005AbWBOHKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:10:24 -0500
Date: Wed, 15 Feb 2006 07:10:18 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: psusi@cfl.rr.com, jzb@aexorsyst.com, linux-kernel@vger.kernel.org
Subject: Re: root=/dev/sda1 fails but root=0x0801 works...
Message-ID: <20060215071018.GJ27946@ftp.linux.org.uk>
References: <200602132316.15992.jzb@aexorsyst.com> <43F1FA74.80607@cfl.rr.com> <20060214162458.GD27946@ftp.linux.org.uk> <20060214225950.3a697ec8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214225950.3a697ec8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:59:50PM -0800, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > Read init/do_mounts.c::name_to_dev_t().
> >
> 
> I tried to do that a while ago, when I was trying to use it for
> name_to_dev_t()ing in swsusp somewhere.
> 
> 
> >From my notes at the time:
> 
>   a) It barfs if /sys is already mounted.

It's called from late boot code.
 
>   b) Fix that, mkdir and mount barf because it needs set_fs(KERNEL_DS)

It's called from late boot code, running as kernel thread.

>   c) Fix that, it barfs because name_to_dev_t is just broken.  It is
>      accessing the wrong pathnames in /sys.

Details, please.
