Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWHVGc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWHVGc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 02:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWHVGc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 02:32:26 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:51653 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750947AbWHVGcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 02:32:25 -0400
Date: Tue, 22 Aug 2006 08:31:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Patrick McHardy <kaber@trash.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter@lists.netfilter.org
Subject: Re: ipt_MARK/xt_MARK usage problem
In-Reply-To: <44EAA447.1080004@trash.net>
Message-ID: <Pine.LNX.4.61.0608220830110.24532@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0608220815560.24532@yvahk01.tjqt.qr>
 <44EAA447.1080004@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>No, its a bug in the iptables userspace version you're using, which
>makes it report any error as "Unknown error 4294967295". The
>error itself is that you're using MARK in the filter table.
>
>> Works without problems. Am I missing something?
>> How do I get MARK back to work in -t filter -- possibly without hacking in 
>> xt_MARK.c?
>
>You won't, its not supposed to work in the filter table.

This worked in 2.6.16, where the ipt_mark_reg_v1 strucutre in xt_MARK.c did 
not have a .table limiter. (It also worked in practice, i.e. packets got 
marked like they should.) I do not see why this was changed.


Jan Engelhardt
-- 
