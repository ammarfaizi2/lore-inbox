Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283659AbRLEBPr>; Tue, 4 Dec 2001 20:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283657AbRLEBPb>; Tue, 4 Dec 2001 20:15:31 -0500
Received: from dsl-213-023-038-097.arcor-ip.net ([213.23.38.97]:65298 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S283644AbRLEBPN>;
	Tue, 4 Dec 2001 20:15:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Giacomo Catenazzi <cate@dplanet.ch>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Date: Wed, 5 Dec 2001 02:17:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011204111115.A15160@thyrsus.com> <3C0CFF5F.3090404@dplanet.ch> <E16BJiE-0000RR-00@starship.berlin>
In-Reply-To: <E16BJiE-0000RR-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16BQgT-0000Ua-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 4, 2001 06:50 pm, Daniel Phillips wrote:
> On December 4, 2001 05:52 pm, Giacomo Catenazzi wrote:
> > I don't think esr changed non problematic rules, but one:
> > all rules without help become automatically dependent to
> > CONFIG_EXPERIMENTAL. I don't like it, but I understand why
> > he makes this decision.
> 
> I love it.

Having thought about this a little more, I don't think it's correct.  It's 
cute and I still love the idea of forcing people to document - I sometimes 
imagine there exist contributors who make a point of not documenting - but 
the need for a clean design with as few corner cases as possible trumps that.

Suppose I'm working on my patch, doing the part that hooks into config.  It 
works, I can see my new feature, but for some strange reason the buttons are 
grayed out.  After I fiddle a while I clue in to the idea that the 
'experimental' setting might have something to do with it, I turn it on and 
then my buttons work.  Now, what the?  Eventually I figure out this is 
supposed to be a feature, not a bug, and that including some help will 
activate my buttons.  So I curse the author up and down and submit a patch to 
remove that feature.

This is a admittedly a small point and I'm not going to quibble about it any 
more.  I'm happy the kbuild process is being cleaned up.  I've wasted too 
much time due to shortcomings in the old one.

I'll wait until this gets into the tree before submitting my patch ;-)

--
Daniel
