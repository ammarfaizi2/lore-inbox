Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWFPVlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWFPVlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWFPVlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 17:41:51 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:62725 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S1751495AbWFPVlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 17:41:50 -0400
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Subject: Re: tg3 timeouts with 2.6.17-rc6
From: "Michael Chan" <mchan@broadcom.com>
To: "Juergen Kreileder" <jk@blackdown.de>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <87k67glrvl.fsf@blackdown.de>
References: <1551EAE59135BE47B544934E30FC4FC041BD16@NT-IRVA-0751.brcm.ad.broadcom.com>
 <87k67glrvl.fsf@blackdown.de>
Date: Fri, 16 Jun 2006 14:42:41 -0700
Message-ID: <1150494161.26368.39.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006061606; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230322E34343933323430442E303032442D412D;
 ENG=IBF; TS=20060616214144; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006061606_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 688DFA1D4I824581285-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 23:20 +0200, Juergen Kreileder wrote:
> Michael Chan <mchan@broadcom.com> writes:
> 
> >
> > Did this use to work with an older kernel or older tg3 driver? If
> > yes, what version?
> 
> Works fine with 2.6.16 and earlier.
> 
> > Please also provide the full tg3 probing output during modprobe and
> > ifconfig up. Thanks.
> 
Looking at the patch history since 2.6.16, the only patch that could
have an impact is the one that enables TSO by default.

Please try turning TSO off to see if it makes a difference:

ethtool -K eth0 tso off

