Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUKIMOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUKIMOB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKIMLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:11:47 -0500
Received: from [211.58.254.17] ([211.58.254.17]:1988 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261536AbUKIMLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:11:20 -0500
Date: Tue, 9 Nov 2004 21:11:09 +0900
From: Tejun Heo <tj@home-tj.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, diffie@gmail.com,
       linux-kernel@vger.kernel.org, diffie@blazebox.homeip.net,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041109121109.GA31781@home-tj.org>
References: <9dda349204110611043e093bca@mail.gmail.com> <20041107024841.402c16ed.akpm@osdl.org> <20041108075934.GA4602@elte.hu> <20041107234225.02c2f9b6.akpm@osdl.org> <20041108224259.GA14506@kroah.com> <20041108212747.33b6e14a.akpm@osdl.org> <20041109071455.GA11643@kroah.com> <20041109080509.GA10724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109080509.GA10724@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 12:05:09AM -0800, Greg KH wrote:
> Ah, found it.  Was caused by a patch from Tejun Heo <tj@home-tj.org>
> that went into the tree in my last round of driver core changes.
> 
> Tejun, the call to unlink() in the error path in kobject_add() does a
> kobject_put().  Your patch added an extra kobject_put() which caused bad
> things to happen when we failed.

 Yeah, that's right.  I thought I had a unreleased kobject due to
above code but I must have been confused somewhere.  Sorry about that.

 Please forgive me. :-)

-- 
tejun

