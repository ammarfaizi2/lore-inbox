Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWH1JvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWH1JvH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWH1JvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:51:07 -0400
Received: from ns.suse.de ([195.135.220.2]:39388 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932477AbWH1JvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:51:04 -0400
From: Andi Kleen <ak@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Mon, 28 Aug 2006 11:50:53 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060820013121.GA18401@fieldses.org> <200608211803.28867.ak@suse.de> <20060821164550.GB3678@fieldses.org>
In-Reply-To: <20060821164550.GB3678@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281150.53196.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> It looks like that's the deference of context on line 221:
> 		stack = (unsigned long*)context->previous_esp;
> 
> So "context" was 0000b000?? OK, I don't know this code at all, so I'm
> probably not going to figure out anything useful here.

I double checked this now again and I think Jan's patch 

ftp://ftp.firstfloor.org/pub/ak/x86_64/late-merge/patches/backtracer-stuck-in-apic_timer_interrupt

should fix it. I plan to submit that one for 2.6.18

-Andi
