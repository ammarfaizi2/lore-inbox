Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031332AbWI1CYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031332AbWI1CYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 22:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031334AbWI1CYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 22:24:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:46544 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1031332AbWI1CYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 22:24:49 -0400
X-Authenticated: #5039886
Date: Thu, 28 Sep 2006 04:24:47 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Andrew Morton <akpm@osdl.org>, Martin Filip <bugtraq@smoula.net>,
       linux-kernel@vger.kernel.org, Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: forcedeth - WOL [SOLVED]
Message-ID: <20060928022447.GA3890@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Andrew Morton <akpm@osdl.org>, Martin Filip <bugtraq@smoula.net>,
	linux-kernel@vger.kernel.org, Ayaz Abdulla <aabdulla@nvidia.com>
References: <1159379441.9024.7.camel@archon.smoula-in.net> <20060927183857.GA2963@atjola.homenet> <1159389486.8902.4.camel@archon.smoula-in.net> <20060927165704.613bf0aa.akpm@osdl.org> <20060928000447.GB2963@atjola.homenet> <20060928004053.GA3521@atjola.homenet> <20060928010133.GB3521@atjola.homenet> <20060927183625.5231e969.akpm@osdl.org> <20060928020438.GC3521@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060928020438.GC3521@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.09.28 04:04:38 +0200, Björn Steinbrink wrote:
> On 2006.09.27 18:36:25 -0700, Andrew Morton wrote:
> > On Thu, 28 Sep 2006 03:01:33 +0200
> > Björn Steinbrink <B.Steinbrink@gmx.de> wrote:
> > 
> > > > > > Do we know if this reversal *always* happens with this driver, or only
> > > > > > sometimes?
> > > 
> > > I only tried 2.6.18 twice this time, but when I wrote my own tool to do
> > > it, I had probably 20-30 power on -> ethtool -> poweroff cycles before I
> > > decided to look into Bugzilla. As it looked like being fixed already and
> > > I did use the nForce NIC for testing only, I didn't spend any further
> > > time on it back then.
> > 
> > What I'm angling towards is: "is this just a driver bug"?
> 
> I just took a peek at the code.
> 
> The version on bugzilla (last attachment, comment #22), which was
> reported to work correctly, has the MAC address reversal hardcoded.
> The driver in 2.6.18 has some logic to detect if it should reverse the
> MAC address. So it looks like a hardware oddity/bug that the driver
> wants to fix but fails. I'll see what happens if I force address
> reversal and if I can decipher anything, but probably someone else will
> have to cast the runes...

OK, please excuse me wasting your time, it's late over here... I've
actually been looking at Linus' git tree (pulled yesterday) while
writing that mail, not 2.6.18.
2.6.18 does _not_ contain the address reversal detection.
Using the git tree instead of 2.6.18 WOL works as expected, without
having to reverse the MAC address.

Björn
