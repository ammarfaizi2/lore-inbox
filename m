Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVCPBuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVCPBuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 20:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVCPBuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 20:50:10 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14488 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262392AbVCPBuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 20:50:04 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] SquashFS
References: <4235BAC0.6020001@lougher.demon.co.uk>
	<20050315003802.GH3163@waste.org> <42363EAB.3050603@yahoo.com.au>
	<20050315004759.473f6a0b.pj@engr.sgi.com>
	<42370442.7020401@lougher.demon.co.uk>
	<20050315172724.GO32638@waste.org>
	<42370B14.50608@lougher.demon.co.uk>
	<20050315110632.07fc8d09.pj@engr.sgi.com>
From: Junio C Hamano <junkio@cox.net>
Date: Tue, 15 Mar 2005 17:50:02 -0800
In-Reply-To: <20050315110632.07fc8d09.pj@engr.sgi.com> (Paul Jackson's
 message of "Tue, 15 Mar 2005 11:06:32 -0800")
Message-ID: <7vmzt4pdf9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "PJ" == Paul Jackson <pj@engr.sgi.com> writes:

PJ> There is not a concensus (nor a King Penguin dictate) between the
PJ> "while(1)" and "for(;;)" style to document.

FWIW, linux-0.01 has four uses of "while (1)" and two uses of
"for (;;)" ;-).

./fs/inode.c:   while (1) {
./fs/namei.c:   while (1) {
./fs/namei.c:   while (1) {
./kernel/sched.c:       while (1) {

./init/main.c:  for(;;) pause();
./kernel/panic.c:       for(;;);

What is interesting here is that the King Penguin used these two
constructs with consistency.  The "while (1)" form was used with
normal exit routes with "if (...) break" inside; while the
"for(;;)" form was used only in unusual "the thread of control
should get stuck here forever" cases.

So, Phillip's decision to go back to his original while(1) style
seems to be in line with the style used in the original Linux
kernel ;-).

