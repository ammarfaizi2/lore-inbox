Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262226AbRERBal>; Thu, 17 May 2001 21:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262227AbRERBab>; Thu, 17 May 2001 21:30:31 -0400
Received: from felix.convergence.de ([212.84.236.131]:6057 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S262226AbRERBa2>;
	Thu, 17 May 2001 21:30:28 -0400
Date: Fri, 18 May 2001 03:29:23 +0200
From: Felix von Leitner <leitner@convergence.de>
To: linux-kernel@vger.kernel.org
Subject: problem: reading from (rivafb) framebuffer is really slow
Message-ID: <20010518032923.A17686@convergence.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When benchmarking DirectFB, I found that a typical software alpha
blending rectangle fill is completely dominated (I'm talking 90% of the
CPU cycles here) by the time it takes to read pixels from the
framebuffer.

The pixels are read linearly in chunks of aligned 32-bit words.  It's a
Geforce 2 GTS in 1024x768 with 32-bit color depth using rivafb.  This
looks quite crass to me.  Any ideas?  Maybe rivafb does not initialize
AGP and the card is in PCI mode or something?

Felix
