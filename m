Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751860AbWCVAVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbWCVAVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWCVAVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:21:04 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:15587 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751860AbWCVAVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:21:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
Date: Wed, 22 Mar 2006 11:21:15 +1100
User-Agent: KMail/1.8.3
Cc: john stultz <johnstul@us.ibm.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
References: <20060320122449.GA29718@outpost.ds9a.nl> <1142968999.4281.4.camel@leatherman> <8764m7xzqg.fsf@duaron.myhome.or.jp>
In-Reply-To: <8764m7xzqg.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221121.16168.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006 08:19 am, OGAWA Hirofumi wrote:
> john stultz <johnstul@us.ibm.com> writes:
> > In my TOD rework I've dropped the triple read, figuring if a problem
> > arose we could blacklist the specific box. This patch covers that, so it
> > looks like a good idea to me.
> >
> > I've not tested it myself, but if you feel good about it, please send it
> > to Andrew.
>
> Current patch is the following. If I'm missing something, or you have
> some comment, please tell me. (Since I don't have ICH4, ICH4 detection
> is untested)
>
> Thanks.

Looks good. Just some minor grammar comments

+ * The power management timer may return improper result when read.

Change to "may return an improper result" or "may return improper results"

+                       printk(KERN_WARNING
+                              "* Found PM-Timer Bug on this chip. For 
workarounds a bug, this timer\n"
+                              "* source is slow. Other timer source may be 
proper (clock=)\n");

Change "Other timer source may be proper" to "Consider trying other timer 
sources"


+                      "* This chipset may have PM-Timer Bug, For workarounds 
a bug,\n"
+                      "* this timer source is slow. If you are sure, please 
use \"pmtmr_good\"\n"
+                      "* for disabling the workaround\n");


Change "For workarounds a bug" to "Due to workarounds for a bug"
Change "If you are sure" to "If you are sure your timer does not have this 
bug"
Change "for disabling the workaround" to "to disable the workaround"

Cheers,
Con
