Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWAQTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWAQTxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWAQTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:53:44 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:18636
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932421AbWAQTxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:53:43 -0500
Subject: Re: Linux 2.6.16-rc1 - hrtimer hotfix
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 20:54:08 +0100
Message-Id: <1137527648.17180.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 00:19 -0800, Linus Torvalds wrote:
> Ok, it's two weeks since 2.6.15, and the merge window is closed.

Please pull from

master.kernel.org:/pub/scm/linux/kernel/git/tglx/hrtimer-2.6.git

	tglx


 itimer.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff-tree 52ae41e3d11d6f1828c5827861b7b83b7e854222 (from
2664b25051f7ab96b22b199aa2f5ef6a949a4296)
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Jan 17 20:03:14 2006 +0100

    [hrtimers] Fixup itimer conversion

    The itimer conversion removed the locking which protects
    the timer and variables in the shared signal structure.
    Steven Rostedt found the problem in the latest -rt patches.

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


