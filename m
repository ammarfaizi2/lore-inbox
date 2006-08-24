Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWHXEhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWHXEhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 00:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965336AbWHXEhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 00:37:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964891AbWHXEhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 00:37:04 -0400
Date: Wed, 23 Aug 2006 21:35:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 4/6] BC: user interface (syscalls)
Message-Id: <20060823213512.88f4344d.akpm@osdl.org>
In-Reply-To: <1156354182.3007.37.camel@localhost.localdomain>
References: <44EC31FB.2050002@sw.ru>
	<44EC369D.9050303@sw.ru>
	<44EC5B74.2040104@sw.ru>
	<20060823095031.cb14cc52.akpm@osdl.org>
	<1156354182.3007.37.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 18:29:42 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Mer, 2006-08-23 am 09:50 -0700, ysgrifennodd Andrew Morton:
> > On Wed, 23 Aug 2006 17:43:16 +0400
> > Kirill Korotaev <dev@sw.ru> wrote:
> > 
> > > +asmlinkage long sys_set_bclimit(uid_t id, unsigned long resource,
> > > +		unsigned long *limits)
> > 
> > I'm still a bit mystified about the use of uid_t here.  It's not a uid, is
> > it?
> 
> Its a uid_t because of setluid() and twenty odd years of existing unix
> practice. 
> 

I don't understand.  This number is an identifier for an accounting
container, which was somehow dreamed up by userspace.

AFAICT it is wholly unrelated to user ID's.

(How does userspace avoid collisions, btw?)
