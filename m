Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262560AbTCMVrv>; Thu, 13 Mar 2003 16:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262566AbTCMVrv>; Thu, 13 Mar 2003 16:47:51 -0500
Received: from ns.suse.de ([213.95.15.193]:26634 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262560AbTCMVrl>;
	Thu, 13 Mar 2003 16:47:41 -0500
To: Rob Ekl <lkhelp@rekl.yi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sendfile, loopback, and TCP header checksum
References: <Pine.LNX.4.53.0303131510060.10653@rekl.yi.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Mar 2003 22:58:27 +0100
In-Reply-To: Rob Ekl's message of "13 Mar 2003 22:35:32 +0100"
Message-ID: <p73fzpr3p4s.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Ekl <lkhelp@rekl.yi.org> writes:

> Is this something that even needs to be addressed, since the receiver
> would discard the packet if the checksum is incorrect, but since it's over
> loopback, there's no chance of receiving data corrupted by the transport
> medium and loopback ignores the checksum?

This is an intentional optimization. Loopback doesn't need checksums,
so it doesn't generate or check them.

-Andi
