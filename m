Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWANGws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWANGws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWANGws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:52:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751047AbWANGwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:52:47 -0500
Date: Sat, 14 Jan 2006 01:52:35 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: 2.6.15-git breaks Xorg on em64t
Message-ID: <20060114065235.GA4539@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,
 Sometime in the last week something was introduced to Linus'
tree which makes my dual EM64T go nuts when X tries to start.
By "go nuts", I mean it does various random things, seen so
far..
- Machine check. (I'm convinced this isn't a hardware problem
  despite the new addition telling me otherwise :)
- Reboot
- Total lockup
- NMI watchdog firing, and then lockup

I've tried backing out a handful of the x86-64 patches, and
didn't get too far, as some of them are dependant on others,
it quickly became a real mess to try to bisect where exactly it broke.

Any ideas for potential candidates to try & back out ?

		Dave

