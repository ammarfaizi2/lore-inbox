Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263907AbTJ1JuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTJ1JuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:50:08 -0500
Received: from gprs197-51.eurotel.cz ([160.218.197.51]:6275 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263907AbTJ1JuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:50:05 -0500
Date: Tue, 28 Oct 2003 10:49:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, jsimmons@infradead.org,
       geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Cursor problems still in test9
Message-ID: <20031028094907.GA1319@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[And they get worse in fbcon-test patches I tried].

Try this on 2.4 (with vesafb).

echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"

...then try it on 2.6, type foo in bash then delete it using
backspace; ghost cursors stay there. Run emacs and quit it (it sets
cursor to very visible). Boom, special cursor settings are gone.

And now, use gpm on text console to select some text. Hold down left
button, move mouse a bit. Sometimes cursor gets corrupted and stays
there.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
