Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWEBRBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWEBRBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWEBRBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:01:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54942 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964933AbWEBRBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:01:21 -0400
From: Andi Kleen <ak@suse.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: sched_clock() uses are broken
Date: Tue, 2 May 2006 19:01:13 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <20060502165009.GA4223@flint.arm.linux.org.uk>
In-Reply-To: <20060502165009.GA4223@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605021901.13882.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 18:50, Russell King wrote:

> You're right assuming you have a 64-bit TSC, but ARM has at best a
> 32-bit cycle counter which rolls over about every 179 seconds - with
> gives a range of values from sched_clock from 0 to 178956970625 or
> 0x29AAAAAA81.
> 
> That's rather more of a problem than having it happen every 208 days.

Ok but you know it's always 32bit right? You can fix it up then
with your proposal of a sched_diff()

The problem would be fixing it up with a unknown number of bits.

-Andi
