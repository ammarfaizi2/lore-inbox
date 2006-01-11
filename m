Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWAKMfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWAKMfr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWAKMfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:35:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:62102 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751435AbWAKMfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:35:46 -0500
From: Andi Kleen <ak@suse.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Console debugging wishlist was: Re: oops pauser.
Date: Wed, 11 Jan 2006 13:31:45 +0100
User-Agent: KMail/1.8.2
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr> <43C4F8EE.10201@gmail.com>
In-Reply-To: <43C4F8EE.10201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111331.45940.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 13:24, Antonino A. Daplas wrote:

> In the VGA console, all buffers, including scrollback is in video RAM, but
> the size is fixed and is very small.

I wonder if that can be fixed.

> With the framebuffer console, you can increase the size of the scrollback
> buffer with the boot option:
> 
> fbcon=scrollback:<n> (default is 32K)

On x86-64 vesafb is unusable slow because it does CPU scrolling cause
it can't use the vesa BIOS - and the others don't work everywhere. So I don't
think fbcon is an usable replacement.

-Andi
