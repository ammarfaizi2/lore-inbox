Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262916AbTCKMsp>; Tue, 11 Mar 2003 07:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262919AbTCKMsp>; Tue, 11 Mar 2003 07:48:45 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:20217 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262916AbTCKMso>;
	Tue, 11 Mar 2003 07:48:44 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15981.56745.912228.109975@gargle.gargle.HOWL>
Date: Tue, 11 Mar 2003 13:59:21 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic thread_info->status
 field.
In-Reply-To: <Pine.LNX.4.44.0303101658210.6802-100000@home.transmeta.com>
References: <200303110056.h2B0uo6U005286@harpo.it.uu.se>
	<Pine.LNX.4.44.0303101658210.6802-100000@home.transmeta.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > > Sorry for being dense, but can you clarify: will current 2.{2,4,5}
 > > kernels preserve or destroy the parent process' FPU control at fork()?
 > 
 > They're guaranteed to preserve the control state (it has to: you can't 
 > just change the exception mask over a function call). However, that was 
 > buggy at least in 2.5.x, and very possibly in 2.4.x too - haven't checked.

Thanks. Our use of unmasked FPU exceptions should be safe then, unless
2.4 also has the bug you fixed in 2.5.

/Mikael
