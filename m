Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTLTMko (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 07:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTLTMkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 07:40:43 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3456 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264126AbTLTMkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 07:40:33 -0500
Date: Sat, 20 Dec 2003 12:46:25 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312201246.hBKCkP4a000191@81-2-122-30.bradfords.org.uk>
To: ryutaroh@it.ss.titech.ac.jp, vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031220.185244.71103628.ryutaroh@it.ss.titech.ac.jp>
References: <20031219123645.GA28801@ucw.cz>
 <20031220.183049.74735752.ryutaroh@it.ss.titech.ac.jp>
 <20031220093532.GB6017@ucw.cz>
 <20031220.185244.71103628.ryutaroh@it.ss.titech.ac.jp>
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > By the way, the bar key on JP 106 keyboard is actually the backslash
> > > key and bar is equal to shift-backslash on JP 106. But there is
> > > another backslash key (scancode 0x73) and input of backslash is not a
> > > problem.
> > 
> > Keycode 183 is correct for the japanese backslash key. 2.4 didn't
> > differentiate, 2.6 does. You just need to update your keymap.
> 
> 2.4 kernel does differentiate two backslash key on JP 106 keyboard.
> 
> When I press lower-right backslash (scancode 0x73), I get keycode
> 89 on both Linux 2.4 and 2.6.
> 
> When I press upper-right backslash (scancode 0x7d), whose key top is
> Japanese yen and bar, I get keycode 124 on Linux 2.4 but 183 on Linux
> 2.6.
> 
> Is the change of keycode of upper-right backslash a new feature of
> Linux 2.6? What is the advantage of this new feature?

The placement of some keys seems to have changed over time.  For
example, tilde was once shift-0, whilst shift-caret was once overbar.
My keyboard is marked in this way, and I am used to using shift-0 for
tilde, however, shift-caret is apparently now popular as tilde, with
shift-0 producing nothing.

Backslash and Yen share the same code in 8-bit variations of
ASCII-based.  Therefore, the lower-right backslash key and the
upper-right Yen key may in some cases be used interchangably.

However, with unicode representations, both backslash and Yen and
tilde and overbar have separate codes and I personally think it would
be a good idea to default to the traditional key-mappings, so that
these characters can be easily input on systems which correctly
support them.

Note - whilst I am fairly sure the above information is accurate, I am
less sure about the following:

As I understand it there was traditionally a distinction between pipe,
(a broken vertical line), and bar, (solid vertical line).

The markings on my keyboard are as follows:

Pipe is the fourth character on the lower-right backslash key.
Bar is the second character on the upper-right yen key.

However, my keyboard emulates a US one in Set 2, and produces the
Linux 'pipe' symbol, for example as in

cat foo | less

when the bar key is pressed.

John.
