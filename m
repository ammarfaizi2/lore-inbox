Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbTFBBVB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 21:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264778AbTFBBVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 21:21:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23234 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264777AbTFBBVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 21:21:01 -0400
Date: Sun, 01 Jun 2003 18:32:35 -0700 (PDT)
Message-Id: <20030601.183235.74726832.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306011858.h51IwlsG022457@ginger.cmf.nrl.navy.mil>
References: <20030529173637.GZ24054@conectiva.com.br>
	<200306011858.h51IwlsG022457@ginger.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Sun, 01 Jun 2003 14:57:02 -0400
   
   but on a single processor machine (i.e. #undef CONFIG_SMP) there is
   no chance that there will be reads/writes from other processors so
   i dont need any locking OR protection from interrupts.

Either you need to pretect a code sequence from an IRQ context
execution while holding the lock or you don't. :-)

Really, all your macros just make the driver that much less
portable.  And I don't see what you'll gain by having interrupts
enabled for such short sequences of code on uniprocessor.
