Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270040AbTGMAUL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 20:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270044AbTGMAUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 20:20:11 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:27572 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S270040AbTGMAUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 20:20:06 -0400
Date: Sun, 13 Jul 2003 01:37:27 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: David van Hoose <davidvh@cox.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.69-bk1] Modprobe error with agpgart
Message-ID: <20030713003727.GC16201@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	David van Hoose <davidvh@cox.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <3EB80FE0.4040707@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB80FE0.4040707@cox.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 02:41:20PM -0500, David van Hoose wrote:

[digging through large email backlog]

 > I get the following with modprobe when I try to probe agpgart with the 
 > following lines in my modprobe.conf.
 > 
 > Entries in /etc/modprobe.conf:
 > alias char-major-10-175 agpgart
 > options agpgart agp_try_unsupported=1
 > 
 > Error in dmesg:
 > agpgart: Unknown parameter `agp_try_unsupported'
 > 
 > Is this a problem in modprobe or in the agpgart driver?

In case you didn't figure it out yet, the option is no longer
part of the agpgart.ko, but has now moved to the chipset specific
module (via-agp.ko, intel-agp.ko, sis-agp.ko etc...)

		Dave
