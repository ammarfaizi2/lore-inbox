Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752074AbWJXFta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbWJXFta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 01:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWJXFta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 01:49:30 -0400
Received: from DENETHOR.UNI-MUENSTER.DE ([128.176.180.180]:32990 "EHLO
	denethor.uni-muenster.de") by vger.kernel.org with ESMTP
	id S1752074AbWJXFt3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 01:49:29 -0400
Date: Tue, 24 Oct 2006 07:49:09 +0200
From: Borislav Petkov <petkov@math.uni-muenster.de>
To: Michael Buesch <mb@bu3sch.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, info-linux@geode.amd.com
Subject: Re: [PATCH] do not compile AMD Geode's hwcrypto driver as a module per default
Message-ID: <20061024054909.GB6694@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
References: <20061021081745.GA6193@zmei.tnic> <1161602705.19388.22.camel@localhost.localdomain> <200610232221.14265.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200610232221.14265.mb@bu3sch.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 10:21:14PM +0200, Michael Buesch wrote:
> On Monday 23 October 2006 13:25, Alan Cox wrote:
> > Ar Sad, 2006-10-21 am 10:17 +0200, ysgrifennodd Borislav Petkov:
> > > This one should be probably made dependent on some #define saying that the cpu
> > > is an AMD and has the LX Geode crypto hardware built in. Turn it off for now.
> > 
> > That makes no real sense. Most kernel selections are "run on lots of
> > processor types", we thus want as much as possible modular, built and
> > available.
> > 
> > The existing defaults seem quite sane.
> 
> I can only second that.
> Building it as a module does not hurt, except few k disk space.
> But that does not really hurt, given today's disk sizes. ;)
> And if you have a small disk, you can still disable it.

I get that, but my concern was primarily with the increasing build durations of
the kernel whenever new modules get added in and people want them to be built on
as many systems as possible so as to catch as more bugs as possible. But since
we _want_ that, diskspace is not an issue. 

However, it still does not help that much since I can only test-build the module 
but not test-use it for I don't have the hardware.

-- 
Regards/Gruﬂ,
    Boris.
