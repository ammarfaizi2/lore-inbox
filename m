Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVDBStE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVDBStE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 13:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDBStE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 13:49:04 -0500
Received: from wing.tritech.co.jp ([202.33.12.153]:41347 "HELO
	wing.tritech.co.jp") by vger.kernel.org with SMTP id S261177AbVDBStA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 13:49:00 -0500
Date: Sun, 03 Apr 2005 03:48:58 +0900 (JST)
Message-Id: <20050403.034858.70218818.ooyama@tritech.co.jp>
To: cw@f00f.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel stack size
From: ooyama eiichi <ooyama@tritech.co.jp>
In-Reply-To: <20050402182438.GA29095@taniwha.stupidest.org>
References: <20050402175345.GA28710@taniwha.stupidest.org>
	<20050403.031542.23015132.ooyama@tritech.co.jp>
	<20050402182438.GA29095@taniwha.stupidest.org>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Apr 03, 2005 at 03:15:42AM +0900, ooyama eiichi wrote:
> 
> > in i386 and ia64.
> 
> search for CONFIG_DEBUG_STACKOVERFLOW in arch/i386/kernel/irq.c

Oh, very good information for me.

> 
> ia64 has fairly large stacks so you probably won't need to check there
> if you get the above working

in ia64, he works properly.

> 
> > because my driver hungs the machine by an certain ioctl.  and it
> > seems to me there is no bad in the code correspond to the ioctl,
> > except for that it is using large auto variables.  (some functions
> > are useing ~1KB autos)
> 
> don't do that, even if you make it 'apparently' work for you it will
> just end up being a problem mater on or for someone else
> 

I changed these to using kmalloc().
(but not yet confirmed for my driver to work properly)

Thanks very much.

