Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265419AbSJSA0P>; Fri, 18 Oct 2002 20:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265422AbSJSA0P>; Fri, 18 Oct 2002 20:26:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5580 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265419AbSJSA0O>;
	Fri, 18 Oct 2002 20:26:14 -0400
Date: Fri, 18 Oct 2002 17:23:27 -0700 (PDT)
Message-Id: <20021018.172327.11877875.davem@redhat.com>
To: levon@movementarian.org
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021019002645.GA16882@compsoc.man.ac.uk>
References: <20021017011623.GA9096@compsoc.man.ac.uk>
	<20021016.181213.35446337.davem@redhat.com>
	<20021019002645.GA16882@compsoc.man.ac.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: John Levon <levon@movementarian.org>
   Date: Sat, 19 Oct 2002 01:26:45 +0100
   
   Now all we need is for whoever ports oprofiled to a 32-bit on 64-bit
   platform to add some check for finding out the kernel's idea of what
   sizeof(unsigned long) is, and using that to read /dev/oprofile/buffer.
   
   Yeah ?

Wouldn't that someone be you?  It's not that hard to code, and if
it's in there from the start it would really save all of us a lot
of time.

Really, the oprofiled work to do this is going to be generic, what
isn't the generic is the "determine kernel pointer size" check.
But you can make x86 return '4' from the get-go and then people like
me will have a simple place to add the proper test for our platform.
