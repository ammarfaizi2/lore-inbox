Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUIPVVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUIPVVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUIPVVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:21:41 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:9696 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266427AbUIPVVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:21:15 -0400
Date: Thu, 16 Sep 2004 23:21:11 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Message-ID: <20040916212111.GC31479@MAIL.13thfloor.at>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	linux-kernel@vger.kernel.org
References: <41474B15.8040302@nortelnetworks.com> <20040914201210.GE13788@redhat.com> <pan.2004.09.16.21.11.47.825104@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.09.16.21.11.47.825104@smurf.noris.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 11:11:48PM +0200, Matthias Urlichs wrote:
> Hi, Dave Jones wrote:
> 
> > diffsplit will split it into a patch-per-file, which could be
> > a good start. If you have multiple changes touching the same file
> > however, things get a bit more fun, and you get to spend a lot
> > of time in your favorite text editor glueing bits together.
> 
> You can rip the bits apart instead, and leave the glueing and rip-patching
> to the computer.
> 
> - edit patch file:
>   - delete all the parts you don't want applied; freely hand-edit stuff,
>     and don't worry about the pesky line numbers
>   - save to new patch file
> - run "rediff" to fix up the new file
> - run "interdiff" to create a second, clean patch file
>   containing just the deleted parts
> - iterate until finished
> 
> All of this is part of the nice patchutils package.
> 
> NB: if all else fails, use espdiff(1).

yes, this often helps me to get it right, where the
other patchutils seem to fail, but the option parsing
code seems to be broken :)

# espdiff -h
espdiff: invalid option -- h
Try `cat --help' for more information.
     ~~~

> -- 
> Matthias Urlichs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
