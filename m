Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTEMQJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTEMQJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:09:17 -0400
Received: from palrel12.hp.com ([156.153.255.237]:8354 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262015AbTEMQH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:07:57 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.6969.137647.391163@napali.hpl.hp.com>
Date: Tue, 13 May 2003 09:20:09 -0700
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: davidm@hpl.hp.com, "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
In-Reply-To: <20030513173347.A25865@jurassic.park.msu.ru>
References: <16062.37308.611438.5934@napali.hpl.hp.com>
	<20030511195543.GA15528@suse.de>
	<1052690133.10752.176.camel@thor>
	<16063.60859.712283.537570@napali.hpl.hp.com>
	<1052768911.10752.268.camel@thor>
	<16064.453.497373.127754@napali.hpl.hp.com>
	<1052774487.10750.294.camel@thor>
	<16064.5964.342357.501507@napali.hpl.hp.com>
	<1052786080.10763.310.camel@thor>
	<16064.17852.647605.663544@napali.hpl.hp.com>
	<20030513173347.A25865@jurassic.park.msu.ru>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 13 May 2003 17:33:47 +0400, Ivan Kokshaysky <ink@jurassic.park.msu.ru> said:

  Ivan> On Mon, May 12, 2003 at 06:09:16PM -0700, David Mosberger
  Ivan> wrote:
  >> OK, I believe the only other architecture that sets
  >> "cant_use_aperture" is Alpha.

  Ivan> Note that some Alphas may have "cant_use_aperture" cleared.

"Interesting".

  Ivan> I mean Nautilus - unfortunate product of Athlon northbridge
  Ivan> and EV6 interbreeding... I've just managed to get agpgart
  Ivan> working to some degree on one of these beasts (UP1500), but
  Ivan> with so many ugly and fragile hacks that I'm not sure that I
  Ivan> ever want to submit this. ;-)

If cant_use_aperture isn't set, my patch won't help, but it shouldn't
hurt anything either.  I.e., you should be no worse off than before.

What's the nature of those "ugly and fragile" hacks?  Are you saying
that CPU accesses to AGP space aren't remapped in the "normal" (PC)
way?  Or is it something entirely different?

  >> I asked some Alpha folks several months ago about my patch, but
  >> never got a conclusive answer.  IIRC, on Alpha the physical
  >> address itself determines cacheablity.  If so, we can use
  >> PAGE_KERNEL (which is universal) instead of PAGE_KERNEL_NOCACHE.

  Ivan> Yes.

Thanks for confirming.

	--david

