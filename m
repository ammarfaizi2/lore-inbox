Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWFVVHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWFVVHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWFVVHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:07:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750895AbWFVVHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:07:22 -0400
Date: Thu, 22 Jun 2006 14:07:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       git@vger.kernel.org
Subject: Re: [GIT PATCH] USB patches for 2.6.17
In-Reply-To: <Pine.LNX.4.64.0606221354070.6483@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606221405080.6483@g5.osdl.org>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
 <20060621225134.GA13618@kroah.com> <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
 <20060622181826.GB22867@kroah.com> <20060622183021.GA5857@kroah.com>
 <Pine.LNX.4.64.0606221239100.5498@g5.osdl.org> <20060622200147.GA10712@mars.ravnborg.org>
 <Pine.LNX.4.64.0606221354070.6483@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Linus Torvalds wrote:
> 
> After that, I'm not quite sure what you mean by "--dry-run". Do you mean 
> to know about file-level conflicts? You do need to do the merge in order 
> to know whether the conflicts can be resolved, but even without doing the 
> merge you can look for _file_level_ conflicts by other means.

Btw, what you can always do is just

	git pull <other-end>
	.. look at the result ..
	git reset --hard ORIG_HEAD

and you should be ok. It's obviously not a dry-run, it's more of a "do it 
and then undo it", but hey, it should _work_.

(Look out for dirty state, though. "git pull" will happily pull into a 
dirty tree if the changes don't actually affect any dirty files. The "git 
reset --hard" thing will undo all dirty state, though).

		Linus
