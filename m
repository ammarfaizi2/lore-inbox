Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVF0KJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVF0KJD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 06:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVF0KJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 06:09:03 -0400
Received: from 54.37.77.83.cust.bluewin.ch ([83.77.37.54]:44409 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261398AbVF0KI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 06:08:59 -0400
Date: Mon, 27 Jun 2005 12:07:46 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@gentoo.org: [Bug 93671] mount uses wrong default umask for fat filesystem]
Message-ID: <20050627100746.GC24093@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from bugzilla-daemon@gentoo.org -----

Date: Sun, 26 Jun 2005 23:36:36 +0000
From: bugzilla-daemon@gentoo.org
To: clock@twibright.com
Subject: [Bug 93671] mount uses wrong default umask for fat filesystem

Clear-Text: http://bugs.gentoo.org/show_bug.cgi?id=93671
Secure: https://bugs.gentoo.org/show_bug.cgi?id=93671


stian@nixia.no changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |stian@nixia.no




------- Additional Comments From stian@nixia.no  2005-06-26 16:36 PDT -------
This is not a mount bug, but a kernel-bug. umask=nnn is passed along other
user-flags to the mount syscall as a string, and the kernel-filesystem driver
parses the string and denies the syscall if a syntax-error occures. Not all
filesystems supports umask, so umask is not sent unless spesified. If the mount
man-page claims that umask is defaulted to the current shell umask setting, the
kernel-driver needs to take this into account when umask isn't found in the
string it receives from user-space. Just my 5 cent about this bug

-- 
Configure bugmail: http://bugs.gentoo.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You reported the bug, or are watching the reporter.

----- End forwarded message -----
