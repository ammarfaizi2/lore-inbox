Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVCDA1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVCDA1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVCDAGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:06:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:26824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262750AbVCCX2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:28:38 -0500
Date: Thu, 3 Mar 2005 15:28:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: vonbrand@inf.utfsm.cl, jgarzik@pobox.com, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303152825.08e7e4c6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503030855460.25732@ppc970.osdl.org>
References: <200503031644.j23Gi0Eh011165@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0503030855460.25732@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> Now, I haven't actually gotten any complaints about 2.6.11 (apart from 
> "gcc4 still has problems" with fairly trivial solutions)

There have been quite a few.  Mainly driver stuff again:

Subject: Re: [BUG] 2.4.27 - 2.4.29 tar: /dev/nst0: Warning: Cannot seek: Illegal seekg
Subject: PCMCIA breaks suspend-to-(disk|ram) with 2.6.11
Subject:  2.6.11: iostat values broken ?
Subject: 2.6.11: suspending laptop makes system randomly unstable
Subject: [Bugme-new] [Bug 4281] New: ALPS Touchpad Tap-to-Click Broken
Subject: [Bugme-new] [Bug 4282] New: ALSA driver in Linux 2.6.11 causes a kernel panic when loading the EMU10K1 driver
Subject: [Bugme-new] [Bug 4283] New: weird messages after normal kernel messages with enabled netconsole
Subject: 2.6.11 (stable and -rc) ACPI breaks USB


The biggest problem is the new ACPI-based i8042 probing on Dells.  I'm
kicking myself over that because we *knew* the damn thing was busted, and
people kept on having to add i8042.noacpi=1.  We now have a three-line
work-around-it-until-we-fix-it-for-real patch.
