Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWJJIK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWJJIK6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWJJIK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:10:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965085AbWJJIK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:10:56 -0400
Date: Tue, 10 Oct 2006 01:10:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
Message-Id: <20061010011052.f22a55da.akpm@osdl.org>
In-Reply-To: <653402b90610100031i5132083ewba1240d01981f4ae@mail.gmail.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<653402b90610100031i5132083ewba1240d01981f4ae@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 07:31:23 +0000
"Miguel Ojeda" <maxextreme@gmail.com> wrote:

> On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > +# drivers-add-lcd-support.patch: Pavel says use fbcon
> > +drivers-add-lcd-support.patch
> > +drivers-add-lcd-support-update.patch
> >
> 
> Has the # a special meaning?

It's a comment separator ;)

> I'm going to work on offering the fbcon feature as Pavel requested.

Thanks.  It does sound like making the thing an fbdev is the right way to go.

> suggested 2 ways.
> 
> Pavel's idea: Change the driver so the cfag12864b module will be just
> a framebuffer device, removing access through /dev/cfag12864b.
> 
> My idea: Code a new module called "fbcfag12864b", which will depend on
> cfag12864b and will be the framebuffer device. This way we have both
> devices, and they doesn't affect each other as they are different
> things. So the ks0108 and cfag12864b can stay without any changes.
> Also, if we finally decide we don't want the raw cfag12864b module, it
> is easy to remove it from the cfag12864b and the fbcafg12864b will
> continue working.
> 
> Is there anyone who can decide which idea is better? If not, I will
> code it my way. Also, if the Pavel's idea will be the chosen one, it
> will be easier to put the fbcfag12864b code into the cfag12864b rather
> than the opposite.

I'd have thought that once the device is accessible as an fbdev, there's so
much other software and kernel infrastructure to support that, there's
little point in offering an alternative way of presenting the device to
userspace.
