Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbUCRRM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbUCRRM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:12:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:50817 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262770AbUCRRMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:12:03 -0500
Date: Thu, 18 Mar 2004 09:09:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: tulip (pnic) errors in 2.6.5-rc1
Message-Id: <20040318090907.56a3d458.rddunlap@osdl.org>
In-Reply-To: <16473.52851.367709.934661@alkaid.it.uu.se>
References: <16473.28514.341276.209224@alkaid.it.uu.se>
	<40597123.8020903@pobox.com>
	<405971B3.3080700@pobox.com>
	<16473.32039.160055.63522@alkaid.it.uu.se>
	<40597E68.7090908@pobox.com>
	<16473.52851.367709.934661@alkaid.it.uu.se>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004 17:29:39 +0100 Mikael Pettersson wrote:

| Jeff Garzik writes:
|  > Mikael Pettersson wrote:
|  > > Jeff Garzik writes:
|  > >  > er, oops... lemme find the right patch...
|  > > 
|  > > No change, still a flood of those tulip_rx() interrupt messages.
|  > 
|  > hmmm.  Well, it is something unrelated to tulip driver, then.
| 
| Testing older -bk versions I've found that 2.6.4-bk2
| is Ok but 2.6.4-bk3 has this message flood problem.

Other than the netdev_priv() changes, I see removal of
KERNEL_SYSCALLS and the addition of CONFIG_NET_POLL_CONTROLLER.
Are you enabling CONFIG_NET_POLL_CONTROLLER?
If so, can you test with it disabled?

Thanks,
--
~Randy
