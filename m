Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbUK3Tdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbUK3Tdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbUK3TdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:33:22 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:38001 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262282AbUK3TbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:31:16 -0500
Date: Tue, 30 Nov 2004 20:31:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: George Anzinger <george@mvista.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: A problem with xconfig
Message-ID: <20041130193136.GB8777@mars.ravnborg.org>
Mail-Followup-To: George Anzinger <george@mvista.com>,
	Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
References: <41ABA8E5.4060504@mvista.com> <20041130052824.GA8211@mars.ravnborg.org> <41AC4C1D.1050102@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AC4C1D.1050102@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 02:31:57AM -0800, George Anzinger wrote:
> >
> >It used to be so but was addressed in a patch to scripts/kconfig/Makefile
> >a few weeks ago. Do you see it with latest -linus / -mm?
> 
> Gosh, did I do that.  Forgot to say it was the 2.6.9 kernel.  Am I the only 
> one using xconfig??
No - but the fault only happens when you are starting from a fesh tree.
Running mrporper would not delete the old .so file (kbuild 'lost' knowledge
of it). So most people have just untarred a new kernel on top
of the old one and it still worked.

Also the reason why I failed to fix it in the first place. xconfig and gconfig
worked even after mrproper - because the .so file survived.

	Sam
