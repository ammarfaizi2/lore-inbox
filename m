Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVJCOoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVJCOoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbVJCOoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:44:16 -0400
Received: from newton.gmurray.org.uk ([81.2.114.237]:23500 "EHLO
	newton.gmurray.org.uk") by vger.kernel.org with ESMTP
	id S1750909AbVJCOoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:44:15 -0400
X-DKIM: Sendmail DKIM Filter v0.1.1 newton.gmurray.org.uk j93EiDGk005959
From: Graham Murray <graham@gmurray.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Connection reset by peer - TCP window size oddity ?
References: <Pine.GSO.4.61.0510031241580.29231@scorpio.gold.ac.uk>
X-Hashcash: 1:22:051003:linux-kernel@vger.kernel.org::+wm5VfxnZMJr4uKY:0000000000000000000000000000000004tni
Date: Mon, 03 Oct 2005 15:44:13 +0100
In-Reply-To: <Pine.GSO.4.61.0510031241580.29231@scorpio.gold.ac.uk> (Martin
	Drallew's message of "Mon, 3 Oct 2005 12:56:20 +0100 (BST)")
Message-ID: <87r7b2k6de.fsf@newton.gmurray.org.uk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drallew <m.drallew@fatsquirrel.org> writes:

> A tcpdump follows and, unless I'm misunderstanding the output (quite
> possible) it looks like the kernel is sending outside of the peer's
> TCP window, to which the peer responds by resetting the connection.

I think that you have overlooked one detail in the output. Both
systems have declared window scaling of 2, so when otter sets the
window size of 1984 in the packet it is actually advertising a window
of 7936, which you are not exceeding. You do not say what type of
system otter is (or what OS it is running), so one explanation is that
otter has just mirrored your 'wscale 2' in its SYN-ACK without
actually meaning it.
