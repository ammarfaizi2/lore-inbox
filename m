Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316864AbSGHM0w>; Mon, 8 Jul 2002 08:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSGHM0v>; Mon, 8 Jul 2002 08:26:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316864AbSGHM0u>;
	Mon, 8 Jul 2002 08:26:50 -0400
Date: Mon, 8 Jul 2002 13:29:30 +0100
From: Matthew Wilcox <willy@debian.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>, Oliver Neukum <oliver@neukum.name>,
       Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020708132930.R27706@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0207071702120.10105-100000@hawkeye.luckynet.adm> <200207080131.06119.oliver@neukum.name> <3D28D291.3020706@us.ibm.com> <20020708033409.P27706@parcelfarce.linux.theplanet.co.uk> <3D28FE72.1080603@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D28FE72.1080603@us.ibm.com>; from haveblue@us.ibm.com on Sun, Jul 07, 2002 at 07:52:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 07:52:34PM -0700, Dave Hansen wrote:
> Well, I certainly have the hardware to measure the difference.  But, I 
> seem to remember several conversations in the past where people didn't 
> like this behavior.
> http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&safe=off&threadm=linux.kernel.3C62DABA.3020906%40us.ibm.com

I think this is a very different philosophy.  That's "well, this should
be a spinlock, but sometimes we sleep, and we don't want to think about
it too hard, so let's invent a magical lock".  This is "sometimes we
don't hold semaphores for very long so we can improve performance by
spinning 1000 times before sleeping".

-- 
Revolutions do not require corporate support.
