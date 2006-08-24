Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWHXNIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWHXNIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWHXNIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:08:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:9310 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751330AbWHXNI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:08:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=gGnclkBGuCQfBT9ur8C4T65MosdyqFjlx6KPQ7VivMmauVTdOoNmDcyVef2x0kXwVCFIDQKv+E0YgJD7BVFmf2FQw7Ia2tQmVl17M5GCgyzznOIyFd2IfsQpCSEXFswHQwXlHRYjy93yJUvbJny7aBLalx72S34ddf9lXfiG0S8=
Date: Thu, 24 Aug 2006 17:08:22 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 4/6] BC: user interface (syscalls)
Message-ID: <20060824130822.GA5205@martell.zuzino.mipt.ru>
References: <44EC31FB.2050002@sw.ru> <44EC369D.9050303@sw.ru> <44EC5B74.2040104@sw.ru> <20060823095031.cb14cc52.akpm@osdl.org> <1156354182.3007.37.camel@localhost.localdomain> <20060823213512.88f4344d.akpm@osdl.org> <1156417456.3007.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156417456.3007.72.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 12:04:16PM +0100, Alan Cox wrote:
> Ar Mer, 2006-08-23 am 21:35 -0700, ysgrifennodd Andrew Morton:
> > > Its a uid_t because of setluid() and twenty odd years of existing unix
> > > practice.
> > >
> >
> > I don't understand.  This number is an identifier for an accounting
> > container, which was somehow dreamed up by userspace.
>
> Which happens to be a uid_t. It could easily be anyother_t of itself and
> you can create a container_id_t or whatever. It is just a number.
>
> The ancient Unix implementations of this kind of resource management and
> security are built around setluid() which sets a uid value that cannot
> be changed again and is normally used for security purposes. That
> happened to be a uid_t and in simple setups at login uid = luid = euid
> would be the norm.
>
> Thus the Linux one happens to be a uid_t. It could be something else but
> for the "container per user" model whatever a container is must be able
> to hold all possible uid_t values. So we can certainly do something like
>
> typedef uid_t	container_id_t;

What about cid_t? Google mentions cid_t was used in HP-UX specific IPC (only if
_INCLUDE_HPUX_SOURCE is defined).

