Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUHNPng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUHNPng (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 11:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUHNPng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 11:43:36 -0400
Received: from 64.89.71.154.nw.nuvox.net ([64.89.71.154]:22994 "EHLO
	gate.apago.com") by vger.kernel.org with ESMTP id S263778AbUHNPnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 11:43:33 -0400
SMTP-Relay: dogwood.freil.com
Message-Id: <200408141543.i7EFhVft003498@dogwood.freil.com>
X-Mailer: exmh version 2.0.2 2/24/98
To: linux-kernel@vger.kernel.org
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Aug 2004 11:43:31 -0400
From: "Lawrence E. Freil" <lef@freil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 8:51AM William Lee Irwin III wrote:
>Please try to reproduce this with CONFIG_HIGHMEM=y but using mem=700M
>This will tell me something useful beyond "boot with less RAM".
>
>-- wli

wli,

I did as you suggested and booted a kernel with HIMEM set but mem
set to 700M in boot params:

user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e8000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000002bc00000 (usable)
0MB HIGHMEM available.
700MB LOWMEM available.

I get the same behaviour as if I had not specified HIMEM (fast directory
access)  The exact same kernel without the mem=700M runs slow.


-- 
        Lawrence Freil                      Email:lef@freil.com
        1768 Old Country Place              Phone:(770) 667-9274
        Woodstock, GA 30188


