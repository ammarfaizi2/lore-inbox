Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVCBWgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVCBWgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVCBWcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:32:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56209 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262549AbVCBW2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:28:36 -0500
Date: Wed, 2 Mar 2005 17:28:26 -0500
From: Dave Jones <davej@redhat.com>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
Message-ID: <20050302222826.GS1512@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
	akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050228192001.GA14221@apps.cwi.nl> <1109721162.15795.47.camel@localhost.localdomain> <20050302075037.GH20190@apps.cwi.nl> <20050302080255.GA28512@redhat.com> <1109771140.20986.3.camel@localhost.localdomain> <20050302222106.GI20190@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302222106.GI20190@apps.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 11:21:06PM +0100, Andries Brouwer wrote:
 > On Wed, Mar 02, 2005 at 01:45:43PM +0000, Alan Cox wrote:
 > > On Mer, 2005-03-02 at 08:02, Dave Jones wrote:
 > > > If there are any of them still being used out there, I'd be even
 > > > more surprised if they're running 2.6.  Then again, there are
 > > > probably loonies out there running it on 386/486's. 8-)
 > > 
 > > I have one here running 2.4 still. I can test a 2.6 fix for the mtrr
 > > init happily enough.
 > 
 > Good. If I understand things correctly - you or davej or someone will
 > correct me otherwise - failing to initialise mtrr does not break anything,
 > it would just mean slower access to certain kinds of memory for certain
 > kinds of access patterns. (Would you test using an X benchmark?)

The winchips had a funky feature where you could mark system ram
writes as out-of-order. This led to something like a 25% speedup iirc
on benchmarks that did lots of memory copying. lmbench showed
significant wins iirc, but any results I had saved are long since
wiped out in hard disk failures/cruft removal over the years.

 > Below roughly speaking the same patch as before, but with calls
 > to the cyrix and centaur mtrr init routines inserted.

Looks ok on a quick eyeball.

		Dave

