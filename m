Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVHRT7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVHRT7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 15:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVHRT7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 15:59:42 -0400
Received: from dsl3-63-249-67-204.cruzio.com ([63.249.67.204]:6313 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S932417AbVHRT7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 15:59:42 -0400
Date: Thu, 18 Aug 2005 12:58:17 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508181958.j7IJwHIf011275@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I haven't used any of the RT patches since V0.7.51-xx, but I upgraded to -rt8 
>yesterday and had a couple of problems. I've just noticed you released -rt9, 
>but I don't think my problem is listed as fixed.. I'll upgrade anyway, in a 
>minute.

>The problem I'm having is that when the kernel probes my IDE devices it slows 
>down, taking ages to complete the probe. Henceforth the kernel seems to work 
>at a slower speed doing just about anything (compiling, etc.), but 
>interactive performance is okay. It's a bizarre problem.

Similar symptoms happened to me recently and it turned out I had accidently
omitted support for my mb ide chipset (ata_piix) while shrinking my config so
the kernel was unable to set dma mode. Took me a while to find because everything
was working (in PIO mode) just really slowly :-)

