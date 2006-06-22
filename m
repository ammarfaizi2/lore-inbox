Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932738AbWFVAwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWFVAwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWFVAwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:52:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29838 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932738AbWFVAwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:52:00 -0400
Date: Wed, 21 Jun 2006 17:51:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
In-Reply-To: <20060621225134.GA13618@kroah.com>
Message-ID: <Pine.LNX.4.64.0606211749460.5498@g5.osdl.org>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
 <20060621225134.GA13618@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jun 2006, Greg KH wrote:
> 
> Ok, but how?  I'm generating the diffstat in my script with:
> 
> 	git diff origin..HEAD | diffstat -p1 >> $TMP_FILE
> 
> Is there a better way to see these renames?  In playing around with 'git
> diff' I didn't see how to do it, but I'm probably just not looking for
> the right option...

Look at the "diff-options" documentation. 

It's "-M" for "Detect renames" (or use -C, which actually detects copies 
too, but that will be somewhat more expensive).

That works with any diff output (ie "git log -p -M" will give log output 
with patches and rename detection turned on).

		Linus
