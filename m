Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSJQWxf>; Thu, 17 Oct 2002 18:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJQWxe>; Thu, 17 Oct 2002 18:53:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11456 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262303AbSJQWxe>;
	Thu, 17 Oct 2002 18:53:34 -0400
Date: Thu, 17 Oct 2002 15:51:57 -0700 (PDT)
Message-Id: <20021017.155157.58460849.davem@redhat.com>
To: ast@domdv.de
Cc: greg@kroah.com, hch@infradead.org, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DAF3EF1.50500@domdv.de>
References: <20021017185352.GA32537@kroah.com>
	<20021017.131830.27803403.davem@redhat.com>
	<3DAF3EF1.50500@domdv.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andreas Steinmetz <ast@domdv.de>
   Date: Fri, 18 Oct 2002 00:51:29 +0200

   For the next few years 99% of the linux users won't use GBit ethernet, 
   so why don't you remove these drivers from the kernel?
   
The vast majority of desktop computers today ship with gigabit
ethernet interfaces on the motherboard.

So you are wrong, people use it today.

As per the rest of your email, most of my disagreement has to do
with the fact that the implementation isn't optimal.  Going back
to USB, it's optimal because it falls into one of two possible
categories:

1) If I don't use it, and it's built as a module, it takes up
   no resources on my computer.

2) The facilities added to support feature X also helps make
   things like Y and Z possible.

Things like #2 are the things Al Viro is talking about.

So instead of "security_ops()->this, security_ops()->that" being
sprinkled merrily all over the VFS, we have something useful to things
outside of LSM such as full file */fd attributes.

Frankly, as a side effect of no effort being put into #2, the LSM user
level interface is complete shit.  As is the hook mechanism.
