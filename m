Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTG1LVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTG1LVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:21:46 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:56586 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262290AbTG1LVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:21:13 -0400
Date: Mon, 28 Jul 2003 13:36:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Claas Langbehn <claas@rootdir.de>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 has i8042 mux problems
Message-ID: <20030728113626.GA1706@win.tue.nl>
References: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org> <20030728052614.GA5022@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728052614.GA5022@rootdir.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 07:26:14AM +0200, Claas Langbehn wrote:

> I am not sure, if i understand it, but here I could not use my old
> keyboard with kernel 2.6.0-test1. The kernel switched off the keyboard
> controller while booting.
> My keyboard is about 10-12 years old, but it always worked.
> There should be a switch for lilo/grub to override the testing.
> 
> I have got a via KT400a chipset. The keyboard is an AT/XT-switchable
> keyboard. With a newer PS2-Keyboard it works.

Interesting. Yes, the new keyboard driver knows far too much about
keyboards, and that knowledge is right only in 98% of the cases.
No doubt we'll be forced to back out a lot of probing done now.

Nevertheless it would be interesting to see precisely what happens.
Could you try to change the #undef DEBUG in drivers/input/serio/i8042.c
into #define DEBUG and report what output you get at boot time?

