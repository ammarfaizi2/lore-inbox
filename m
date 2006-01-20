Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWATQHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWATQHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWATQHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:07:45 -0500
Received: from free.wgops.com ([69.51.116.66]:34053 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1750923AbWATQHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:07:45 -0500
Date: Fri, 20 Jan 2006 09:07:16 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <20060120155919.GA5873@stiffy.osknowledge.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120155919.GA5873@stiffy.osknowledge.org>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 4:59:19 PM +0100 Marc Koschewski 
<marc@osknowledge.org> wrote:

> For my daily work I use the -git kernels on my production machines. And I
> didn't have probs for a long time due to stuff being tested in -mm. -mm
> is mostly broken for me (psmouse, now reiserfs, ...) but I tend to say
> that 2.6 is rock-stable.
>
> When it comes to API stability people are encouraged to stay up-to-date
> when when developing stuff out of the kernel tree, ain't they? A more
> convenient way would be to create a new in-kernel-tree wrapper module
> that wraps some functions no longer available anymore and which are
> possible to be wrapped in the meaning of all needed data is provided to
> the 'old' method and can be easyily wrapped into the new function.
>
> It could a Kconfig option so that the 'wrapper module' is only activated
> on demand. Thus, having the option to port driver directly to the new API
> or just silenty use the 'wrapper module' to translate the call while
> being noisy at compile time.
>
> You're free to write the module... ;)

I know this, but the in-kernel stuff is far less painful than when all this 
stuff bleeds to userland.  Besides, can you imagine such a beast of a 
module? :D  I mean yeouch, the maintenance.  And it'd encourage the sort of 
thing we as kernel developers in general want to discourage, which is the 
use of deprecated APIs.

Lots of things still out there depend on devfs.  So now if I want to 
develop my kmod on recent kernels I have to be in the business of 
maintaining a lot more userland stuff, like mkinitrd, installers, etc. that 
have come to rely on devfs.

The point is this is happening in what is being called a stable kernel. 
Stable it isn't.  The whole devfs thing is likely to cause me a lot of 
work, I'd stay with 2.4 in the worst affected things, but I can't.  devfs 
is newish for and already been deprecated and killed before a major release 
even, that just seems not right.

Anyway hopefully this thread wills tart some constructive thought on this 
rather than being pointless, but I had to get it out there.  I know I have 
a habit of showing up every other year or so. :)
