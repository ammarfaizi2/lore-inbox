Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752415AbWAFHGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbWAFHGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbWAFHGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:06:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3225 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752416AbWAFHGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:06:17 -0500
Date: Fri, 6 Jan 2006 08:06:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops pauser.
In-Reply-To: <43BE0592.3040200@shaw.ca>
Message-ID: <Pine.LNX.4.61.0601060804100.22809@yvahk01.tjqt.qr>
References: <5rvok-5Sr-1@gated-at.bofh.it> <5ryvR-2aN-5@gated-at.bofh.it>
 <5rAHn-5kc-9@gated-at.bofh.it> <43BE0592.3040200@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> After an oops, we can't really rely on anything. What if the
>> oops came from the console layer, or a framebuffer driver?

How about this?:

Put an "emergency kernel" into a memory location that is being protected in 
some way (i.e. writing there even from kernel space generates an oops). 
Upon oops, it gets unlocked and we do some sort of kexec() to it.
Of course, this probably requires that the unlocking must not be done 
with help of the standard page mappings.


Jan Engelhardt
-- 
