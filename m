Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTLVB7f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLVB7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:59:35 -0500
Received: from mx1.net.titech.ac.jp ([131.112.125.25]:36108 "HELO
	mx1.net.titech.ac.jp") by vger.kernel.org with SMTP id S264300AbTLVB7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:59:32 -0500
Date: Mon, 22 Dec 2003 10:59:29 +0900 (JST)
Message-Id: <20031222.105929.41650224.ryutaroh@it.ss.titech.ac.jp>
To: john@grabjohn.com
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
From: ryutaroh@it.ss.titech.ac.jp
In-Reply-To: <200312201246.hBKCkP4a000191@81-2-122-30.bradfords.org.uk>
References: <20031220093532.GB6017@ucw.cz>
	<20031220.185244.71103628.ryutaroh@it.ss.titech.ac.jp>
	<200312201246.hBKCkP4a000191@81-2-122-30.bradfords.org.uk>
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thank you for your comments.
I agree to your description of keyboards and character sets.

From: John Bradford <john@grabjohn.com>
> > Is the change of keycode of upper-right backslash a new feature of
> > Linux 2.6? What is the advantage of this new feature?
> 
> The placement of some keys seems to have changed over time.  For
> example, tilde was once shift-0, whilst shift-caret was once overbar.
> My keyboard is marked in this way, and I am used to using shift-0 for
> tilde, however, shift-caret is apparently now popular as tilde, with
> shift-0 producing nothing.
> 
> Backslash and Yen share the same code in 8-bit variations of
> ASCII-based.  Therefore, the lower-right backslash key and the
> upper-right Yen key may in some cases be used interchangably.
(deleted)

But I haven't completely understand why the keycode of yen-"solid
vertical line" was changed.

(1) Backslash-underscore key (scancode 0x73) and yen-"solid vertical
    line" key (scancode 0x7d) were given different keycodes (89 and
    124) in Linux 2.4 . Do we have to change the keycode of yen-"solid
    vertical line" key (scancode 0x7d) in Linux 2.6?

(2) I don't see why the new keycode is 183. Yen in Unicode is 165.

(3) The topic is keycode of the key having scancode 0x7d. In my
    understanding, the assignment of keycodes has little to do with
    what is printed on key top. Key tops are taken care by keymaps
    loaded by loadkeys(1).

(4) Are there other keyboards having the key with scancode 0x7d? If
    there are keyboards with scancode 0x7d in other languages, we
    should take them into account.

Ryutaroh
