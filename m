Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752536AbWAFUS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbWAFUS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbWAFUS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:18:56 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:8748 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752536AbWAFUSz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:18:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BooUGCNQkksjxPf3OIbrjL7IZ/ZFthPrSkAjKKBCp0SMTTPjUFNE6CqmOMCs1eN4njaHGhAGgJ8ugknvsTxwtpYsIBo/tUMRp7F9cLggENQg4M84d9+/mYpx6fWpdFTMNfvIBf8PbuYUtM1nKU0CSYh48G35A6+Z/kZ4BORXZYk=
Message-ID: <d120d5000601061218x1d99fdbbkc397c7c07631e42b@mail.gmail.com>
Date: Fri, 6 Jan 2006 15:18:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: command line parsing broken in 2.6.15-git?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060106120642.5062482e@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105163922.7806343b@dxpl.pdx.osdl.net>
	 <200601052051.46344.dtor_core@ameritech.net>
	 <20060106120642.5062482e@dxpl.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> On Thu, 5 Jan 2006 20:51:46 -0500
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> > On Thursday 05 January 2006 19:39, Stephen Hemminger wrote:
> > > The command line parsing or psmouse driver is broken now, this
> > > makes my mouse go wacky on a KVM. It worked up until the latest
> > > git updates (post 2.6.15)
> > >
> > > Dmesg output:
> > >
> > > Kernel command line: root=/dev/md2 vga=0x31a ro selinux=0 psmouse.proto=bare
> > > Unknown boot option `psmouse.proto=bare': ignoring
> > >
> >
> > Stephen,
> >
> > I don't know about parameter parsing but if you could test the patch
> > below I'd appreciate it - it deals with resynchronizing PS/2 mouse and
> > should help with KVMs.
> >
> > Thanks!
> >
>
> Thanks that does fix the KVM mouse screwup, but the module param issue still needs fixing.
>

I won't dispute that, it was just a shameless plug of my patch ;)
Thank you for testingit.

--
Dmitry
