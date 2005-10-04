Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVJDFG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVJDFG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 01:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVJDFG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 01:06:57 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:50278 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751186AbVJDFG4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 01:06:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bqHgY2E1gLg9ZpVK+oajrddpMGxu/lyniAxMtE8nGYnbCxcheeP9+pmwGWkrj7hiSX72ULAQjnZ2tjMWQYsLkUaVWX6a1Rdq5E29umZJLXdbRvEqhuxxSU6GAmPKT4tEECy4g2QfZ4dfxMVEj4WwZO2hkCgtOO1bnsFrrnVizps=
Message-ID: <aec7e5c30510032206l12f666a0lef42ba7919d860fe@mail.gmail.com>
Date: Tue, 4 Oct 2005 14:06:55 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 07/07] i386: numa emulation on pc
Cc: Magnus Damm <magnus@valinux.co.jp>,
       Isaku Yamahata <yamahata@valinux.co.jp>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1128356192.10290.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <20050930073308.10631.24247.sendpatchset@cherry.local>
	 <1128106512.8123.26.camel@localhost>
	 <aec7e5c30510030259j2698f982ue7169768730f3d53@mail.gmail.com>
	 <1128356192.10290.10.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Mon, 2005-10-03 at 18:59 +0900, Magnus Damm wrote:
> > > > +#ifdef CONFIG_NUMA_EMU
> > > ...
> > > > +#endif
> > >
> > > Ewwwwww :)  No real need to put new function in a big #ifdef like that.
> > > Can you just create a new file for NUMA emulation?
> >
> > Hehe, what is this, a beauty contest? =) I agree, but I guess the
> > reason for this code to be here is that a similar arrangement is done
> > by x86_64...
>
> If that's really the case, can they _actually_ share code?  Maybe we can
> do this NUMA emulation thing in non-arch code.  Just guessing...

I'd like to avoid duplication as much as you, but at a quick glance
the x86_64 and i386 architecture looked pretty different. But I will
see what I can do.

> > I will create a new file. Is arch/i386/mm/numa_emu.c good?
>
> > But first, you have written lots and lots of patches, and I am
> > confused. Could you please tell me on which patches I should base my
> > code to make things as easy as possible?
>
> This is the staging ground for my memory hotplug work.  But, it contains
> all of my work on other stuff, too.  If you build on top of this, it
> would be great:
>
> http://sr71.net/patches/2.6.14/2.6.14-rc2-git8-mhp1/

I will build on top of that then.

Thanks,

/ magnus
