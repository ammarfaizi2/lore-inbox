Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbSJPVnN>; Wed, 16 Oct 2002 17:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbSJPVmA>; Wed, 16 Oct 2002 17:42:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23732 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261459AbSJPVlL>;
	Wed, 16 Oct 2002 17:41:11 -0400
Date: Wed, 16 Oct 2002 14:38:43 -0700 (PDT)
Message-Id: <20021016.143843.99745166.davem@redhat.com>
To: levon@movementarian.org
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021016164057.GB85246@compsoc.man.ac.uk>
References: <200210160156.DAA25005@faui11.informatik.uni-erlangen.de>
	<20021015.190019.41374479.davem@redhat.com>
	<20021016164057.GB85246@compsoc.man.ac.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: John Levon <levon@movementarian.org>
   Date: Wed, 16 Oct 2002 17:40:57 +0100
   
   I'm not sure that's an option :
   
   o userspace needs to know the size of the cookie in the event buffer
   o userspace would like to use the cookie as a hash value to avoid
     repeated lookups
   
   Perhaps the best solution would be to use a separate u32 ID value,
   allocated linearly. I could just refuse to allocate new dcookies in
   theoretical case of overflow.
   
   The other possibility is a dcookiefs (cat
   /dev/oprofile/dcookie/34343234) but that's a lot of extra
   code/complexity ...
   
I don't understand why using a bigger type is not an option.

Why not just use u64?  That would work too.
