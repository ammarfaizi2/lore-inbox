Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbTHETYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbTHETYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:24:12 -0400
Received: from codepoet.org ([166.70.99.138]:45711 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270608AbTHETYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:24:02 -0400
Date: Tue, 5 Aug 2003 13:23:55 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org, dri-users@lists.sourceforge.net
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with Radeon 7500
Message-ID: <20030805192355.GA9098@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Ruben Puettmann <ruben@puettmann.net>, linux-kernel@vger.kernel.org,
	dri-users@lists.sourceforge.net
References: <20030805164925.GA6646@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805164925.GA6646@puettmann.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 05, 2003 at 06:49:25PM +0200, Ruben Puettmann wrote:
> DRI doesn't work with Radeon 7500 on IBM Thinkpad R40 (2722).
[-----------snip---------------]
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
[-----------snip---------------]
> XFree86 : 4.2.1
> 
> 
> Both glxgears and tuxracer crashes with the Illegal instruction error
> message. the strace output of glxgears is:
[-----------snip---------------]
> ioctl(3, FIONREAD, [0])                 = 0
> ioctl(5, 0x40186448, 0xbffffb30)        = 0
> --- SIGILL (Illegal instruction) @ 0 (0) ---
> +++ killed by SIGILL +++


I get this too, with vanilla 2.4.22-pre10....

$ lspci | grep VGA
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
$ lspci | grep AGP
00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller (rev 02)

$ strace glxgears
[-----------snip---------------]
ioctl(3, FIONREAD, [0])                 = 0
ioctl(4, 0x40186448, 0xbffff4d0)        = 0
--- SIGILL (Illegal instruction) @ 0 (0) ---
+++ killed by SIGILL +++

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
