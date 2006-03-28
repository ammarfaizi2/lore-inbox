Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWC1WpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWC1WpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWC1WpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:45:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10938 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932481AbWC1WpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:45:03 -0500
Date: Tue, 28 Mar 2006 14:44:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Trond.Myklebust@netapp.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] config: Fix CONFIG_LFS option
Message-Id: <20060328144452.12812f25.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603281430370.15714@g5.osdl.org>
References: <1143584319.8199.34.camel@lade.trondhjem.org>
	<Pine.LNX.4.64.0603281430370.15714@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Tue, 28 Mar 2006, Trond Myklebust wrote:
> >
> > The help text says that if you select CONFIG_LBD, then it will
> > automatically select CONFIG_LFS. Nope... That isn't currently the
> > case.
> 
> I'm not sure your patch makes anything much better, though.
> 
> Why does CONFIG_LSF exist in the first place? Afaik, it only affects a 
> totally not-very-interesting thing (blkcnt_t) for a totally not very 
> interesting feature (the number of people who want single files >2TB is 
> likely not very big).

Yes, it's strictly a bugfix, but it's not a very big bug.  Perhaps we
should turn it on all the time and not have the config option, but it does
have some cost in text size, data size and instruction count.

> Having it auto-selected by LBD sounds insane, since LBD is likely more 
> interesting than LSF itsef is. It would make more sense to go the other 
> way (have LSF auto-select LBD).

Spose so.  I wonder what distributors will choose to do.

It's a bit odd to have a config option to select whether or not to have a
buggy kernel.

