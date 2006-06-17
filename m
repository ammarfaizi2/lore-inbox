Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWFQB0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWFQB0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 21:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWFQB0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 21:26:42 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:49170 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S1751251AbWFQB0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 21:26:41 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Subject: Re: tg3 timeouts with 2.6.17-rc6
From: "Michael Chan" <mchan@broadcom.com>
To: "Juergen Kreileder" <jk@blackdown.de>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <87bqsslk9e.fsf@blackdown.de>
References: <1551EAE59135BE47B544934E30FC4FC041BD16@NT-IRVA-0751.brcm.ad.broadcom.com>
 <87k67glrvl.fsf@blackdown.de> <1150494161.26368.39.camel@rh4>
 <87bqsslk9e.fsf@blackdown.de>
Date: Fri, 16 Jun 2006 18:27:32 -0700
Message-ID: <1150507652.26368.46.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006061609; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230372E34343933353843302E303030322D412D;
 ENG=IBF; TS=20060617012635; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006061609_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 688D85C30HW32681119-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-17 at 02:05 +0200, Juergen Kreileder wrote:
> Michael Chan <mchan@broadcom.com> writes:
> > Please try turning TSO off to see if it makes a difference:
> >
> > ethtool -K eth0 tso off
> 
> Seems to work fine with TSO disabled.
> 
Thanks for the information. We'll look into it. If possible, please send
me (using private email) an ethereal trace of a sample of the packets
sent by the tg3 chip right before the NETDEV_WATCHDOG timeout.

In the meantime, I wonder if we should disable TSO by default on the
5780 chip for 2.6.17.

