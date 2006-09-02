Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWICHxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWICHxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 03:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbWICHxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 03:53:53 -0400
Received: from khc.piap.pl ([195.187.100.11]:62357 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751681AbWIBW70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 18:59:26 -0400
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc5 with GRE, iptables and Speedtouch ADSL, PPP over ATM
References: <m3odty57gf.fsf@defiant.localdomain>
	<20060902214839.GA27295@electric-eye.fr.zoreil.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 03 Sep 2006 00:59:24 +0200
In-Reply-To: <20060902214839.GA27295@electric-eye.fr.zoreil.com> (Francois Romieu's message of "Sat, 2 Sep 2006 23:48:40 +0200")
Message-ID: <m3ejutan8z.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> writes:

> dev_activate takes BH disabling locks only. How could a softirq happen
> on the same cpu and trigger a deadlock ?

That's BTW "possible circular locking dependency" and there is only
one CPU (no HT, single core - an old mobile Celeron P3).

I have to admit this machine has a history of mysterious hangs (black
screen of death), though I think they are related to LAN and maybe disk
activity, not GRE/PPP/ATM/ADSL (RAM tests ok, the hardware is rather
common - i440BX etc. but who knows).
-- 
Krzysztof Halasa

-- 
VGER BF report: S 0.999877
