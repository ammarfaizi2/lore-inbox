Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVCXHhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVCXHhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVCXHhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:37:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18864 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262425AbVCXHhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:37:09 -0500
Date: Thu, 24 Mar 2005 02:37:03 -0500
From: Dave Jones <davej@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David McCullough <davidm@snapgear.com>, linux-kernel@vger.kernel.org
Subject: Re: API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050324073703.GA19467@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	David McCullough <davidm@snapgear.com>,
	linux-kernel@vger.kernel.org
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050324043300.GA2621@havoc.gtf.org> <20050324044621.GC3124@beast> <Pine.LNX.4.61.0503240815120.24256@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503240815120.24256@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 08:18:35AM +0100, Jan Engelhardt wrote:
 > 
 > >Would you suggest making /dev/random point to /dev/hw_random then ?
 > 
 > No. I for example do not have a hardware RNG, so `modprobe hw_random` fails 
 > with No Such Device. Making it a symlink would make it a dangling one.

It shouldn't be a symlink. Something like rngd should read from it
and feed it into /dev/random's entropy pool.

		Dave

