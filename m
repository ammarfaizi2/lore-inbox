Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUJ0EJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUJ0EJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUJ0EJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:09:37 -0400
Received: from mproxy.gmail.com ([216.239.56.249]:51460 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbUJ0EJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:09:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IiE91NgVSPbi7h4DfVtNYEwPTPPYqsfhverY9gRtz6r1MZ+eRM7YjgnMBb+6rQeOuTknK+PpX1WJH2QYoeJkwZwwEnx9U6Ubk+oqgfhsCreNs5m5fCqM2atUSnZD2xfzosY8UcE1MVd46I4+9YD9acfHL9S+ggxRGX3tPGqFNgw=
Message-ID: <21d7e997041026210935b2954a@mail.gmail.com>
Date: Wed, 27 Oct 2004 14:09:34 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for initramfs image updates [u]
In-Reply-To: <20041026231514.GA3285@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410200849.i9K8n5921516@mail.osdl.org>
	 <1098533188.668.9.camel@nosferatu.lan>
	 <20041026221216.GA30918@mars.ravnborg.org>
	 <1098824849.12420.60.camel@nosferatu.lan>
	 <20041026231514.GA3285@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 01:15:14 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Oct 26, 2004 at 11:07:29PM +0200, Martin Schlemmer [c] wrote:
> 
> 
> 
> > > Current patch will not rebuild image if one of the
> > > programs listed are changed. But it should give a good
> > > foundation to do so.
> > >
> >
> > I will see if I get the time to get that implemented elegantly if
> > you do not beat me to it.
> 
> Something as simple as putting relevant timestamps in the generated
> file as coment should do it.
> If timestamp differ then initramfs_list will be updated and initramfs
> image will be remade.

please put the timestamps somewhere that don't end up in the final kernel....

My life involves reproducing complete FLASH systems at any point in
time exactly the same as the ones I produced at the previous point in
time, I've had to hack about 5 or 6 things in the kernel to do this,
I'd like to try avoiding people adding any more unless they really are
needed.. or at least give me some way to override it ...

Dave.
