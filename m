Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUAMQwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 11:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUAMQwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 11:52:36 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62677 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264384AbUAMQwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 11:52:35 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Benecke <jens@spamfreemail.de>
Subject: Re: 2.6.1mm2: nforce2 / amd74xx IDE driver doesn't load
Date: Tue, 13 Jan 2004 17:56:03 +0100
User-Agent: KMail/1.5.4
References: <2867040.OKCKYgd4AF@spamfreemail.de> <200401131534.53423.bzolnier@elka.pw.edu.pl> <bu13gl$rs2$1@sea.gmane.org>
In-Reply-To: <bu13gl$rs2$1@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401131756.03852.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 of January 2004 16:40, Jens Benecke wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >> I have found a (perhaps THE) reason why my X is so jerky: the nforce2
> >> chipset driver (amd74xx) doesn't load, because it "thinks" the BIOS IDE
> >> ports are disabled - which is definitely not the case
> >
> > It doesn't load because IDE ports are already controlled by generic IDE
> > code.
> > Just use CONFIG_BLK_DEV_AMD74XX=y.  I will fix this "BIOS" comment.
>
> I can't, because I (plan to) use this kernel on many different machines.
> Not all of those (in fact: only one) uses the amd74xx module.

So what?  It won't be used on other machines, but it will eat a little kernel
image space & memory.

> Is there a kernel parameter I can use to disable the generic IDE code on
> boot?

No, but I will later make patch to allow disabling/modularizing it.

--bart

