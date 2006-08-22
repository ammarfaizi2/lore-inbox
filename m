Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWHVGV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWHVGV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 02:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWHVGV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 02:21:59 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:23007 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750768AbWHVGV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 02:21:58 -0400
Date: Tue, 22 Aug 2006 08:21:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter@lists.netfilter.org
Subject: ipt_MARK/xt_MARK usage problem
Message-ID: <Pine.LNX.4.61.0608220815560.24532@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


kernel 2.6.17 ships with xt_MARK, but iptables 1.3.5 still uses ipt_MARK. 
In essence, I cannot use `iptables -j MARK` giving me 

# iptables -A INPUT -j MARK --set-mark 1
iptables: Unknown error 4294967295

I have seen this before and the problem behind this strange error (-1) is 
that the .targetsize/.matchsize variables in the kernel modules do not 
match their userspace parts.

However, this time it seems to be something different:

# iptables -t mangle -A INPUT -j MARK --set-mark 1

Works without problems. Am I missing something?
How do I get MARK back to work in -t filter -- possibly without hacking in 
xt_MARK.c?




Jan Engelhardt
-- 
