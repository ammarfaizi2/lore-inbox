Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSLQBAO>; Mon, 16 Dec 2002 20:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSLQBAN>; Mon, 16 Dec 2002 20:00:13 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:3221 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S263291AbSLQBAN>;
	Mon, 16 Dec 2002 20:00:13 -0500
Date: Tue, 17 Dec 2002 01:06:12 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pawel Kot <pkot@linuxnews.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.24-rc1
Message-ID: <20021217010612.GA32560@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Pawel Kot <pkot@linuxnews.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0212170113350.14563-100000@urtica.linuxnews.pl> <1040088833.13837.115.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040088833.13837.115.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 01:33:53AM +0000, Alan Cox wrote:
 > On Tue, 2002-12-17 at 00:15, Pawel Kot wrote:
 > >                 case X86_VENDOR_AMD:
 > > -                       init_amd(c);
 > > +                       if(init_amd(c))
 > > +                               return;
 > >                         return;
 > > 
 > >                 case X86_VENDOR_CENTAUR:
 > > What does it fix?
 > 
 > If we get a vendor string, we should use it - thats all

This patch also makes us unconditionally skip the mcheck_init
if we have a vendor string. That doesn't seem right.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
