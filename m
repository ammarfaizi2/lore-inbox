Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVKNSTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVKNSTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKNSTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:19:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5093 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751212AbVKNSTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:19:06 -0500
Date: Mon, 14 Nov 2005 13:18:54 -0500
From: Dave Jones <davej@redhat.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051114181854.GB3652@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <1131979779.5751.17.camel@localhost.localdomain> <200511141802.45788.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511141802.45788.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 06:02:45PM +0000, Alistair John Strachan wrote:
 > On Monday 14 November 2005 14:49, Alan Cox wrote:
 > > On Llu, 2005-11-14 at 05:38 -0800, Alex Davis wrote:
 > > > This will break ndiswrapper. Why can't we just leave this in and let
 > > > people choose?
 > >
 > > If we spent our entire lives waiting for people to fix code nothing
 > > would ever happen. Removing 8K stacks is a good thing to do for many
 > > reasons. The ndis wrapper people have known it is coming for a long
 > > time, and if it has a lot of users I'm sure someone in that community
 > > will take the time to make patches.
 > 
 > I honestly don't know if this is the case, but is it conceivable that no patch 
 > could be written to resolve this, because the Windows drivers themselves only 
 > respect Windows stack limits (which are presumably still 8K?).

Windows drivers can actually use more than 8KB. So in some situations,
you're already screwed.  There are already cases where vendors customer
service are now telling people "Use ndiswrapper" when people ask about
Linux support.

If we continue down this path, we'll have no native wireless drivers for Linux.
The answer is not to complain to linux-kernel for breaking ndiswrapper,
but complain to the vendors for not releasing specifications for
native drivers to be written.

		Dave

