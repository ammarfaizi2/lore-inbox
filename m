Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275298AbTHGMee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275308AbTHGMeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:34:10 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:51842 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275298AbTHGMdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:33:18 -0400
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to
	2.6.0-test2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: casino_e@terra.es
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1b4bd91b8e12.1b8e121b4bd9@teleline.es>
References: <1b4bd91b8e12.1b8e121b4bd9@teleline.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060259371.3169.41.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 13:29:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 10:49, CASINO_E wrote:
> > We never check the cable bits for SATA so this is a no-op
> 
> Alan,
> 
> Without this, in 2.4.22-pre10-ac1, ide_ata66_check() in ide-iops.c
> returns 1. This causes, for example, that hdparm -i shows only udma
> modes 0 to 2 (although the drive has been set to udma6) and refuses to
> set any value above udma2 with an ugly "Speed warnings UDMA 3/4/5 is
> not functional".

Then the bug is that ide_ata66_check is getting called at all in the
SATA controller case

