Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVCJAMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVCJAMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVCJAKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:10:45 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:18318 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262519AbVCJAIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:08:55 -0500
Subject: Re: [PATCH] Support for GEODE CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Vrabel <dvrabel@cantab.net>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <422F8623.4030405@cantab.net>
References: <200503081935.j28JZ433020124@hera.kernel.org>
	 <1110387668.28860.205.camel@localhost.localdomain>
	 <20050309173344.GD17865@csclub.uwaterloo.ca>
	 <1110405563.3072.250.camel@localhost.localdomain>
	 <422F8623.4030405@cantab.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110413198.3116.278.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 10 Mar 2005 00:06:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 23:26, David Vrabel wrote:
> Alan Cox wrote:
> > - If you can't turn it off use solid areas of colour to speed the system
> > up (The hardware uses RLE encoding to reduce ram fetch bandwidth)
> 
> How much of a difference does the compression make to performance?

Depends on the resolution but a display that is mostly solid can drop to
1/10th of a fancy background for memory fetch cost. Big deal on 66MHz
SDRAM

> > - The onboard audio is a software SB emulation on older GX. It burns
> > CPU.
> 
> Presumably one could write a native audio driver that didn't use the 
> soundblaster emulation?

The newer ones have native audio, the older ones you could but it would
be hard as the native audio is chip dependant, undocumented and the IRQ
it raises is hard coded to the SMI/SMM line.

