Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbTLRX14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265409AbTLRX14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:27:56 -0500
Received: from platane.lps.ens.fr ([129.199.121.28]:5513 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S265405AbTLRX1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:27:50 -0500
Date: Fri, 19 Dec 2003 00:27:45 +0100
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       devel@XFree86.org
Subject: linux 2.6.0-pre11, XFree fails to start
Message-ID: <20031218232745.GA12716@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have an intermitent bug on my computer (intel PIV, shuttle motherboard,
integrated i845 video card): sometimes, at boot time, XFree (4.3.0,
from redhat 9 package) fails to start. The screen goes black (or, more
precisely, darkgrey) as the video mode is changed, and stays there
forever. Keyboard is not responding (not even caps-lock or sysrq), and I
have to reboot the computer. There is nothing in the log, the only
information are the last lines written by the XServer in
/var/log/XFree86.0.log:

(II) I810(0): xf86BindGARTMemory: bind key 5 at 0x067f8000 (pgoffset 26616)
(II) I810(0): xf86BindGARTMemory: bind key 6 at 0x066f8000 (pgoffset 26360)
(II) I810(0): xf86BindGARTMemory: bind key 7 at 0x05278000 (pgoffset 21112)
(II) I810(0): Before: SWF1 is 0x00000108
(II) I810(0): After: SWF1 is 0x00000108

On a normal boot, those lines are followed by:

(II) I810(0): Display plane A is enabled.
(II) I810(0): Display plane B is disabled.
(II) I810(0): PIPEACONF is 0x80000000

There is nothing peculiar in the logs of the kernel.

As I said, the bug is intermitent. I should say it happens every three or
four boots. Before 2.6.0-pre11, I have been using 2.6.0-pre8 and -pre9,
and I don't remember this problem happening. Or if it did occur, it was
much less frequent. Maybe I should go back to 2.6.0-pre9 to be sure.

I really don't know how to debug a hard lock like this, or how to find
usefull information.

Every interesting information on my computer (config files, lspci, log of
XFree, etc.) is available on <http://perso.nerim.net/~tudia/bug-reports/>.

Éric Brunet

