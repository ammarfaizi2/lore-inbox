Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270828AbTHAQiE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 12:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270831AbTHAQiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 12:38:04 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:42514 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S270828AbTHAQiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 12:38:02 -0400
Date: Fri, 1 Aug 2003 18:37:59 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2: keyboard funnies in textmode
Message-ID: <20030801163759.GA3343@win.tue.nl>
References: <1059747945.2809.2.camel@paragon.slim> <20030801145223.GA3308@win.tue.nl> <1059752011.2691.13.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059752011.2691.13.camel@paragon.slim>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 05:33:31PM +0200, Jurgen Kramer wrote:

> How can I check keycodes while in textmode?

The usual answer is "showkeys" for keycodes, "showkeys -s"
for scancodes. On 2.6 some cheating is involved, since the
driver first translates and then untranslates, so raw mode
is not exactly raw anymore, and replies may be wrong.

For the backslash/pipe key you expect scancode 0x2b
(in the default, translated scancode Set 2) and keycode 43.
X uses its own keycodes, maybe it will be 51, haven't checked.

