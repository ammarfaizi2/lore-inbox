Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWI1Djy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWI1Djy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 23:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWI1Djy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 23:39:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031345AbWI1Djx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 23:39:53 -0400
Date: Wed, 27 Sep 2006 20:39:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Martin Filip <bugtraq@smoula.net>, linux-kernel@vger.kernel.org,
       Ayaz Abdulla <aabdulla@nvidia.com>, stable@kernel.org
Subject: Re: forcedeth - WOL [SOLVED]
Message-Id: <20060927203906.f4fc331e.akpm@osdl.org>
In-Reply-To: <20060928022447.GA3890@atjola.homenet>
References: <1159379441.9024.7.camel@archon.smoula-in.net>
	<20060927183857.GA2963@atjola.homenet>
	<1159389486.8902.4.camel@archon.smoula-in.net>
	<20060927165704.613bf0aa.akpm@osdl.org>
	<20060928000447.GB2963@atjola.homenet>
	<20060928004053.GA3521@atjola.homenet>
	<20060928010133.GB3521@atjola.homenet>
	<20060927183625.5231e969.akpm@osdl.org>
	<20060928020438.GC3521@atjola.homenet>
	<20060928022447.GA3890@atjola.homenet>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 04:24:47 +0200
Björn Steinbrink <B.Steinbrink@gmx.de> wrote:

> On 2006.09.28 04:04:38 +0200, Björn Steinbrink wrote:
> > On 2006.09.27 18:36:25 -0700, Andrew Morton wrote:
> > > On Thu, 28 Sep 2006 03:01:33 +0200
> > > Björn Steinbrink <B.Steinbrink@gmx.de> wrote:
> > > 
> > > > > > > Do we know if this reversal *always* happens with this driver, or only
> > > > > > > sometimes?
> > > > 
> > > > I only tried 2.6.18 twice this time, but when I wrote my own tool to do
> > > > it, I had probably 20-30 power on -> ethtool -> poweroff cycles before I
> > > > decided to look into Bugzilla. As it looked like being fixed already and
> > > > I did use the nForce NIC for testing only, I didn't spend any further
> > > > time on it back then.
> > > 
> > > What I'm angling towards is: "is this just a driver bug"?
> > 
> > I just took a peek at the code.
> > 
> > The version on bugzilla (last attachment, comment #22), which was
> > reported to work correctly, has the MAC address reversal hardcoded.
> > The driver in 2.6.18 has some logic to detect if it should reverse the
> > MAC address. So it looks like a hardware oddity/bug that the driver
> > wants to fix but fails. I'll see what happens if I force address
> > reversal and if I can decipher anything, but probably someone else will
> > have to cast the runes...
> 
> OK, please excuse me wasting your time, it's late over here... I've
> actually been looking at Linus' git tree (pulled yesterday) while
> writing that mail, not 2.6.18.
> 2.6.18 does _not_ contain the address reversal detection.
> Using the git tree instead of 2.6.18 WOL works as expected, without
> having to reverse the MAC address.
> 

hm, OK, thanks.  Ayaz, do you think 5070d3408405ae1941f259acac7a9882045c3be4 is
a suitable thing for 2.6.18.x?
