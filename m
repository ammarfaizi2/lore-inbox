Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTI3JGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbTI3JGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:06:31 -0400
Received: from chello080109223066.lancity.graz.surfer.at ([80.109.223.66]:16777
	"EHLO lexx.delysid.org") by vger.kernel.org with ESMTP
	id S261226AbTI3JGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:06:30 -0400
To: linux-kernel@vger.kernel.org
Subject: /dev/vcs: stuck with dimensions <255?
From: Mario Lang <mlang@delysid.org>
Date: Tue, 30 Sep 2003 11:06:33 +0200
Message-ID: <87oex21w86.fsf@lexx.delysid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I just realized, that /dev/vcsa behaviour is broken when
used with lines or columns more than 255.  I can easily
get this behaviour by using the built-in 4x6 font on a
1024xsomething resolution.  That results in 256 columns.  However,
the vcs devices expose dimensions and cursor position in the first
4 bytes.

My question is now:  Are we stuck with this now?  I found that
it is at least possible to use TIOCGWINSZ on the corresponding
/dev/tty%d device to get correct dimensions, but then again, how
would I optain the cursor position?

I am wondering why a char was choosen at all.  I see no gain
by "saving" space there...

-- 
CYa,
  Mario
