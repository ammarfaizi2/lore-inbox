Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUE0Ofw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUE0Ofw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUE0Ofw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:35:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55269 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264578AbUE0Ofv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:35:51 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Auzanneau Gregory <mls@reolight.net>
Subject: Re: idebus setup problem (2.6.7-rc1)
Date: Thu, 27 May 2004 16:37:40 +0200
User-Agent: KMail/1.5.3
References: <40B5D79C.6000600@reolight.net>
In-Reply-To: <40B5D79C.6000600@reolight.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405271637.40353.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 of May 2004 13:57, Auzanneau Gregory wrote:
> Hello,
>
> It seems there is a problem with idebus parameter with 2.6.7-rc1.
> Indeed, it doesn't take into account lilo append.

Why are you using it in the first place?

Let me guess... you've nForce2 chipset and lspci shows you 66MHz.
You don't need and really shouldn't be using 'idebus=66'.

> With 2.6.7-rc1-mm1, i've got:
> Kernel command line: BOOT_IMAGE=LinuxNEW ro root=304 idebus=66
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

This needs fixing.

I remember seeing patch related to handling '=' in kernel params,
maybe it's related (or maybe not).

> With 2.6.6-mm3, i've got:
> May 24 11:37:43 greg-port kernel: Kernel command line:
> BOOT_IMAGE=LinuxNEW ro root=304 idebus=66
> May 24 11:37:43 greg-port kernel: ide_setup: idebus=66
> May 24 11:37:43 greg-port kernel: ide: Assuming 66MHz system bus speed
> for PIO modes
>
> I tried to seek in the code, but my level is not as good as I would like
> it. :)
>
>
> Thank you all for the good work with linux, keep up with it ! :)

