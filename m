Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbTDNG0U (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 02:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbTDNG0T (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 02:26:19 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:24589 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S262778AbTDNG0T (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 02:26:19 -0400
Message-Id: <200304140629.h3E6TPu01387@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: arjanv@redhat.com, Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: 2.5.67-mm2
Date: Mon, 14 Apr 2003 09:24:26 +0300
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <20030412180852.77b6c5e8.akpm@digeo.com> <20030413151232.D672@nightmaster.csn.tu-chemnitz.de> <1050245689.1422.11.camel@laptop.fenrus.com>
In-Reply-To: <1050245689.1422.11.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 April 2003 17:54, Arjan van de Ven wrote:
> On Sun, 2003-04-13 at 15:12, Ingo Oeser wrote:
> > Hi Andrew,
> > hi lists readers,
> >
> > On Sat, Apr 12, 2003 at 06:08:52PM -0700, Andrew Morton wrote:
> > > +gfp_repeat.patch
> > >
> > >  Implement __GFP_REPEAT: so we can consolidate lots of
> > > alloc-with-retry code.
> >
> > What about reworking the semantics of kmalloc()?
> >
> > Many users of kmalloc get the flags and size reversed (major
> > source of hard to find bugs), so wouldn't it be simpler to have:
>
> that in itself is easy to find btw; just give every GFP_* an extra
> __GFP_REQUIRED bit and then check inside kmalloc for that bit (MSB?)
> to be set.....

This will incur runtime penalty
--
vda
