Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275442AbTHJA4N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 20:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275443AbTHJA4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 20:56:12 -0400
Received: from web14005.mail.yahoo.com ([216.136.175.121]:27655 "HELO
	web14005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S275442AbTHJA4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 20:56:12 -0400
Message-ID: <20030810005611.3976.qmail@web14005.mail.yahoo.com>
Date: Sat, 9 Aug 2003 17:56:11 -0700 (PDT)
From: David Walser <luigiwalser@yahoo.com>
Subject: 2.6.0-test3 input device problems
To: linux-kernel@vger.kernel.org
Cc: Andrey Borzenkov <arvidjaar@mail.ru>
In-Reply-To: <200308100151.39396.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A strange thing is in the configurator (menuconfig or
xconfig) some of the input device options are missing
and/or messed up.  I suppose it's probably related to
the problem I had building it.  At the beginning of
the build, it would go in my .config and change my
CONFIG_SERIO_I8042 and CONFIG_KEYBOARD_ATKBD from m to
y, and then of course there would be problems
building, because atkbd.o which was now set to y, and
therefore put in the built-in.o's and tmp_vmlinux1
depended on symbols in serio.o, which was still set to
m, and therefore wasn't available, and the build would
die.

I had to fix my .config by hand, and then chattr +i it
before the build to get it to build!

PS - CC me if you want me to get any replies

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
