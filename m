Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWEUTVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWEUTVV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWEUTVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:21:21 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:28813 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S964916AbWEUTVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:21:20 -0400
Date: Sun, 21 May 2006 15:21:03 -0400 (EDT)
From: Ameer Armaly <ameer@bellsouth.net>
X-X-Sender: ameer@sg1
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] initialize variables in fs/isofs/namei.c
In-Reply-To: <20060521190806.GE8250@redhat.com>
Message-ID: <Pine.LNX.4.61.0605211518350.10443@sg1>
References: <Pine.LNX.4.61.0605211501150.2255@sg1> <20060521190806.GE8250@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 May 2006, Dave Jones wrote:

> On Sun, May 21, 2006 at 03:02:34PM -0400, Ameer Armaly wrote:
> > This patch removes un-initialized variable warnings for block and offset in
> > namei.c, which are later initialized through a call to isofs_find_entry().
>
> Which indicates the problem lies with gcc, just like with the other patches
> 'fixing' these warnings.
>
I agree.  The compiler should be smart enough to at least consider the 
possibility of initializing through pointers.
> The warning is bogus.
>
It is, but at the same it's clutter; in my opinion, readability is not 
impacted by explicitly initializing variables that get initialized through 
a pointer, and we reduce annoying make output.
  > 		Dave
>
> -- 
> http://www.codemonkey.org.uk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
