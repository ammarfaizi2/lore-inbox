Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273732AbSISXCg>; Thu, 19 Sep 2002 19:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273733AbSISXCg>; Thu, 19 Sep 2002 19:02:36 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:4601 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S273732AbSISXCa>; Thu, 19 Sep 2002 19:02:30 -0400
Subject: Re: MediaGX/Geode performance fix, Was: Which processor/board for
	embedded NTP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christer Weinigel <christer@weinigel.se>
Cc: Robert Schwebel <robert@schwebel.de>, linux-kernel@vger.kernel.org
In-Reply-To: <873cs5vkfb.fsf_-_@zoo.weinigel.se>
References: <1032354632.23252.14.camel@venus>
	<87r8frqech.fsf@zoo.weinigel.se> <20020919060218.GD10773@pengutronix.de> 
	<873cs5vkfb.fsf_-_@zoo.weinigel.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Sep 2002 00:11:47 +0100
Message-Id: <1032477107.29021.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 20:39, Christer Weinigel wrote:
> This mail contains a patch to fix a performance problem with many
> Cyrix MediaGX/NatSemi Geode platforms.  The register settings have
> been officially recommended by NatSemi themselves.  The patch is
> against linux-2.4.20-pre7.  Should this be merged into the mainsteam
> linux kernel?

This wont actually make an iota of difference in most cases. The CS5530
IDE driver will force this value to 0x14 anyway. It also sets MWI on te
X-bus which is needed too.

Probably the fixup should be done in the PCI quirks.

