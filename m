Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUFJN0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUFJN0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUFJN0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 09:26:52 -0400
Received: from main.gmane.org ([80.91.224.249]:58765 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261239AbUFJN0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 09:26:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lars <terraformers@gmx.net>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Thu, 10 Jun 2004 15:26:47 +0200
Message-ID: <ca9nid$bnc$1@sea.gmane.org>
References: <ca9jj9$dr$1@sea.gmane.org> <200406101459.45750.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e7deef.dip.t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

thanks for answering!

rc2 worked completely stable with c1 disconnect halt enabled and low
cpu temp.
rc3 has no C1 enabled after booting, so the cpu temp rises, but its
stable.
when enabling the c1 disconnect halt after this with something like
"setpci -v -H1 -s 0:0.0 6F=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6F) |
0x10)))" 
(from
http://www.tldp.org/HOWTO/Athlon-Powersaving-HOWTO/approaches.html#commandline)
the cpu is getting cool again but the system locks up frequently.

so it would be great to have the fixup re-enabled at boottime.
maybe a switch to force the fixup on boards without c1 disconnect
bios-settings would do it ?


thanks,
lars




Bartlomiej Zolnierkiewicz wrote:

> 
> Do you get lockups with -rc3 and not with -rc2?
> 


