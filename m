Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbUBWPaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUBWP3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:29:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:57808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261927AbUBWP1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:27:41 -0500
Date: Mon, 23 Feb 2004 07:19:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Max Payne <"max..payne"@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 vs. ibm xseries 445 (4 way)
Message-Id: <20040223071936.7e49a664.rddunlap@osdl.org>
In-Reply-To: <freemail.20040123144654.89434@fm1.freemail.hu>
References: <freemail.20040123144654.89434@fm1.freemail.hu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 14:46:54 +0100 (CET) Max Payne <"max..payne"@freemail.hu> wrote:

| Hi!
| 
| Hardware:
| 
| ibm xseries 445, 4 way intel pentium xeon 3GHz, 8GB RAM
| 
| with SuSE Linux SLES8 (2.4.19-64GB-SMP kernel) everything is
| OK, i have 4 CPU (reported by "cat /proc/cpuinfo" and "top") 
| 
| with vanilla 2.6.3 i have only one CPU. Yes, SMP kernel. Any
| idea?
| 
| .config attached

Try changing
CONFIG_NR_CPUS=32
to see if that works.

There have been some issues with CPU number assignments (by
BIOS) being rather sparse.

--
~Randy
