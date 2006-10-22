Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWJVSPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWJVSPs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWJVSPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:15:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28297 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750768AbWJVSPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:15:46 -0400
Date: Sun, 22 Oct 2006 14:15:39 -0400
From: Dave Jones <davej@redhat.com>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sn9c10x list corruption in 2.6.18.1
Message-ID: <20061022181539.GD27152@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Luca Risolia <luca.risolia@studio.unibo.it>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061022031145.GA24855@redhat.com> <200610221346.53038.luca.risolia@studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610221346.53038.luca.risolia@studio.unibo.it>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 01:46:52PM +0200, Luca Risolia wrote:

 > > I found one area in the driver where we do list manipulation without any locking,
 > > but I'm not entirely convinced that this is the source of the bug yet.
 > Spinlocks are not necessary there, becouse that piece of code is already
 > isolated when running, to prevent concurrent accesses to the list from within 
 > the irq handler. 

ok

 > The bug should be elsewhere (probably not in the driver).

But it only happens when the user unplugs the camera, and no other
webcam driver seems to be affected by this problem.

That's fairly conclusive to me that the driver is misbehaving. 

	Dave
 
-- 
http://www.codemonkey.org.uk
