Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUFSPtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUFSPtL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUFSPtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:49:11 -0400
Received: from [81.187.239.184] ([81.187.239.184]:63172 "EHLO
	mail.newtoncomputing.co.uk") by vger.kernel.org with ESMTP
	id S264045AbUFSPtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:49:09 -0400
Date: Sat, 19 Jun 2004 16:49:07 +0100
From: matthew-lkml@newtoncomputing.co.uk
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040619154907.GE5286@newtoncomputing.co.uk>
References: <20040618205355.GA5286@newtoncomputing.co.uk> <1087643904.5494.7.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087643904.5494.7.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 12:18:24PM +0100, David Woodhouse wrote:
> On Fri, 2004-06-18 at 21:53 +0100, matthew-lkml@newtoncomputing.co.uk
> wrote:
> > The main problem seems to be in ACPI, but I don't see any reason for
> > printk to even consider printing _any_ non-printable characters at all.
> > It makes all characters out of the range 32..126 (except for newline)
> > print as a '?'.
> 
> Please don't do that -- it makes printing UTF-8 impossible. While I'd
> not argue that now is the time to start outputting UTF-8 all over the
> place, I wouldn't accept that it's a good time to _prevent_ it either,
> as your patch would do.

Please forgive me if I'm wrong on this, but I seem to remember reading
something a while ago indicating that the kernel is and always will be
internally English (i.e. debugging messages and the like) as there is no
need to bloat it with many different languages (that can be done in
userspace). As printk is really just a log system, I personally don't
see any way that it should ever print anything other than ASCII.

(Yes, of course some parts of the kernel, like filesystems, do need to
be able to handle UTF-8 etc, but not all.)

-- 
Matthew

