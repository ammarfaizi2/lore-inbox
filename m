Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUIJK6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUIJK6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUIJK6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:58:33 -0400
Received: from open.hands.com ([195.224.53.39]:4328 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267360AbUIJK5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:57:07 -0400
Date: Fri, 10 Sep 2004 12:08:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: seems to be impossible to disable CONFIG_SERIAL [2.6.7]
Message-ID: <20040910110819.GE14060@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

has anyone noticed that it's impossible (without hacking) to remove
CONFIG_SERIAL?

remove the entries or set all SERIAL config entries to "n"...
hit make...
CONFIG_SERIAL_8250 gets set to "m", CONFIG_SERIAL gets set to "y"!

seeerrrriiialllll muuuusssstttt dieeeeeee kill kill kill.

actually there is a serious reason: udev at the moment is
taking up a significant amount of startup time (with selinux
enhancements) due to the number of entries to create in /dev.

if the dbus stuff was enabled as well it would be _even longer_.

there are 64 ttys created

there are 64 serial devices created.

only three of these are actually used on my computer - well two at most:
tty0 and tty7.

why in hell's name would i want 128 unnecessary devices created?

i feel a kernel parameter coming on...

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

