Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263971AbRFSHps>; Tue, 19 Jun 2001 03:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263967AbRFSHpi>; Tue, 19 Jun 2001 03:45:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18445 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263971AbRFSHp2>; Tue, 19 Jun 2001 03:45:28 -0400
Subject: Re: gnu asm help...
To: ashok.raj@intel.com (Raj, Ashok)
Date: Tue, 19 Jun 2001 08:44:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ("Linux-Kernel (E-mail)")
In-Reply-To: <9319DDF797C4D211AC4700A0C96B7C9404AC2068@orsmsx42.jf.intel.com> from "Raj, Ashok" at Jun 18, 2001 03:56:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CGBk-0005Xl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need a simple (??) change to atomic_inc() functionality. so that i can
> increment and return the value of the variable.

Please don't blindly change atomic.h to do this. A large number of processors
don't have the x86 'xadd' functionality. Create/use seperate functions instead

