Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVC1TVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVC1TVC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVC1TVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:21:02 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:24840 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262001AbVC1TU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:20:56 -0500
Date: Mon, 28 Mar 2005 21:20:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Olivier Fourdan <fourdan@xfce.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Various issues after rebooting
Message-ID: <20050328192054.GV30052@alpha.home.local>
References: <1112039799.6106.16.camel@shuttle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112039799.6106.16.camel@shuttle>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 28, 2005 at 09:56:39PM +0200, Olivier Fourdan wrote:
(...) 
> I thought of a hardware issue, but in WinXP, everything is fine. And in
> the case of a hardware issue, I guess the problem would always show, not
> just in Linux after a reboot. 
> 
> My guess is that the BIOS doesn't re-initialize the hardware correctly
> in case of a quick shutdown/reboot but WinXP might be initializing the
> things by itself (it's a guess, I'm probably completely wrong).

I had same sort of problems with my crappy VAIO (which, fortunately, is
dead now). The bios did not initialize anything, and there were many
situations where it would not recover after a reboot. The most common one
was the local APIC. It was guaranteed that if I rebooted while I had used
local APIC, the BIOS would not detect the hard disk at next boot ! And if
I booted 2.6 and used the frame buffer, then I would have no screen at
next boot, which was not really a problem since it would also timeout on
the disk 10 seconds later...

> Does that make any sense so someone? How could I help tracking down this
> issue?

Now I have a compaq (nc8000) which does not exhibit such buggy behaviour,
but you can try disabling the APIC too just in case it's a similar problem
(at least in 32 bits, I don't know if you can disable it in 64 bits mode).

Regards,
Willy

