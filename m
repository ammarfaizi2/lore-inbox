Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUABASJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUABASJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:18:09 -0500
Received: from pallas.cela.pl ([213.134.162.12]:47378 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261973AbUABARn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:17:43 -0500
Date: Fri, 2 Jan 2004 01:17:20 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Rob Landley <rob@landley.net>
cc: Rob Love <rml@ximian.com>, Andries Brouwer <aebr@win.tue.nl>,
       Pascal Schmidt <der.eremit@email.de>, <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <200401010634.28559.rob@landley.net>
Message-ID: <Pine.LNX.4.44.0401020051590.29346-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Solve 90% of the problem space and have a human deal with the exceptions.
> How big's the unique number being exported, anyway?  (If it's 32 bits, the 
> exceptions are 1 in 4 billion.  It may never be seen in the wild...)

Wouldn't this be a classical birthday problem with 50% collision chance
popping up in and around a few hundred devices? [20 for 8 bits, 23 for
365, 302 for 16 bits, 77163 for 32 bits], and that's only in a single
system - with hundreds of thousands of systems even a 0.1% collision rate
is deadly. [0.1% collision rate at 32 bits with 2932 devices]  Even with 
only 300 devices per system, you'll still get a collision (at 32 bits) on 
more than 1 system in a hundred thousand.

Cheers,
MaZe.


