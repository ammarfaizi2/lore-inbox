Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbUAMRam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUAMRal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:30:41 -0500
Received: from certiflexdimension.com ([66.137.233.209]:49563 "EHLO
	werewolf.certiflexdimension.com") by vger.kernel.org with ESMTP
	id S264457AbUAMR3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:29:37 -0500
Date: Tue, 13 Jan 2004 11:30:00 -0600
From: Jonathan Angliss <jon@netdork.net>
Reply-To: Jonathan Angliss <jon@netdork.net>
X-Priority: 3 (Normal)
Message-ID: <398633829.20040113113000@netdork.net>
To: linux-kernel@vger.kernel.org
Subject: athlon-xp header issue
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

I'm using a gentoo copy of the 2.4.22 kernel, with various patches
applied to fix various issues, but this issue exists in the 2.4.24
kernel source code that I downloaded from the kernel.org site.

When I set the kernel model to athlon-xp in "menuconfig", it sets
CONFIG_MK7XP=y which is what I'd expect. However the issue comes when
I try to issue "make bzImage", it fails reporting various issues with:

  `CONFIG_X86_L1_CACHE_SHIFT' undeclared here (not in a function)

in a number of files. I did a google search for the error, and didn't
find anything helpful, in fact most of the results appeared to be
about nVidia graphics drivers. I'm no coder, but with a little help
from Jason Munro, I managed to track down the cause of the issue. He
pointed me to this email:

  http://www.ussg.iu.edu/hypermail/linux/kernel/0309.0/2036.html

This gave me a hint. So I took a look in arch/i386/config.in and
noticed that the check for CONFIG_MK7XP is missing. This results in
the appropriate settings not being set. Is this intentional? Or am I
looking in the wrong area for my problem?

If this email warrants a reply, please CC my address, as I am not a
member of this list.

-- 
Jonathan Angliss
(jon@netdork.net)

Insanity is my only means of relaxation

