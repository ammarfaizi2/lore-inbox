Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292535AbSB0Oqe>; Wed, 27 Feb 2002 09:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292533AbSB0Oq1>; Wed, 27 Feb 2002 09:46:27 -0500
Received: from ns.suse.de ([213.95.15.193]:38918 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292508AbSB0OqL>;
	Wed, 27 Feb 2002 09:46:11 -0500
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is TCPRenoRecoveryFail ?
In-Reply-To: <Pine.LNX.3.96.1020227144128.18713E-100000@fafner.axis.se.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Feb 2002 15:46:07 +0100
In-Reply-To: Bjorn Wesen's message of "27 Feb 2002 14:49:43 +0100"
Message-ID: <p73664j9e4w.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Wesen <bjorn.wesen@axis.com> writes:

> Around the time of the packet loss happened, the counter
> TCPRenoRecoveryFail increased by one, but I'm not sufficiently into the
> TCP code to figure out why that happens and if that is the reason why
> Linux stop retransmitting anything.. any ideas ?


TCPRenoRecovery fail just means that fast retransmit didn't help and
it is going into a full retransmit. Fast retransmit is a short cut retransmit
mechanism that works faster when only a few packets got lost. You lost 
more than 1. You have to find out why you are losing them.

-Andi
