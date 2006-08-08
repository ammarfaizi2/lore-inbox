Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWHHLxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWHHLxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWHHLxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:53:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26043 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932226AbWHHLxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:53:31 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <eb8g8b$837$1@taverner.cs.berkeley.edu>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <eb8g8b$837$1@taverner.cs.berkeley.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 13:13:20 +0100
Message-Id: <1155039200.5729.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-07 am 22:52 +0000, ysgrifennodd David Wagner:
> I'm still trying to understand the semantics of this proposed
> frevoke() implementation.  Can an attacker use this to forcibly
> close some other processes' file descriptor?  Suppose the target

No.

> process has fd 0 open and the attacker revokes the file corresponding
> to fd 0; what is the state of fd 0 in the target process?  Is it
> closed?  If the target process then open()s another file, does it

No its revoked. Just like a tty hangup

> get bound to fd 0?  (Recall that open() always binds to the lowest
> unused fd.)  If the answers are "yes", then the security consequences
> seem very scary.

Of course it doesn't. The BSD folk who added revoke were security people
not idiots.

Alan

