Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVJKIxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVJKIxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVJKIxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:53:06 -0400
Received: from ozlabs.org ([203.10.76.45]:20363 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751421AbVJKIxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:53:05 -0400
Subject: Re: [linux-usb-devel] RFC drivers/usb/storage/libusual
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20050928170133.5406f8f4.zaitcev@redhat.com>
References: <20050927205559.078ba9ed.zaitcev@redhat.com>
	 <20050928085159.GA11862@kroah.com>
	 <20050928170133.5406f8f4.zaitcev@redhat.com>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 07:15:04 +1000
Message-Id: <1128978904.8218.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 17:01 -0700, Pete Zaitcev wrote:
> >   - request_module() is icky.  I keep wanting to get rid of that
> >     function, and really don't want to see any further users get added.
> >     But that's just my feeling, if there's no other way to do this, I
> >     don't mind.
> 
> Yes, yes, and yes. And also, it looks to me as if I am trying to do
> something which "obviously" belongs to modprobe or other user mode
> component. The trouble is, I am unable to find a different solution
> which would not involve an alias pointing to an alias, and Rusty's
> modprobe does not allow that. I could hack it up easily, but he
> put in a comment, "that way lies madness". He probably knew what
> he was doing.

I just didn't want to do loop detection.  In userspace you can use an
install command to get the same effect.

Now, why did we want this?  In small words...
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

