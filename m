Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752435AbWAFI6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbWAFI6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbWAFI6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:58:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12715 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752435AbWAFI6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:58:40 -0500
Date: Fri, 6 Jan 2006 03:58:31 -0500
From: Dave Jones <davej@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops pauser.
Message-ID: <20060106085831.GC4595@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Robert Hancock <hancockr@shaw.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <5rvok-5Sr-1@gated-at.bofh.it> <5ryvR-2aN-5@gated-at.bofh.it> <5rAHn-5kc-9@gated-at.bofh.it> <43BE0592.3040200@shaw.ca> <Pine.LNX.4.61.0601060804100.22809@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601060804100.22809@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 08:06:12AM +0100, Jan Engelhardt wrote:
 > >> After an oops, we can't really rely on anything. What if the
 > >> oops came from the console layer, or a framebuffer driver?
 > 
 > How about this?:
 > 
 > Put an "emergency kernel" into a memory location that is being protected in 
 > some way (i.e. writing there even from kernel space generates an oops). 
 > Upon oops, it gets unlocked and we do some sort of kexec() to it.

You just reinvented 'kdump' :)
There's been ongoing work in this area for a while.

		Dave

