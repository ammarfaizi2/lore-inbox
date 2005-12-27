Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVL0I0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVL0I0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 03:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVL0I0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 03:26:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14782 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932262AbVL0I0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 03:26:44 -0500
Date: Tue, 27 Dec 2005 09:26:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikado <mikado4vn@yahoo.com>
cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: How to obtain process ID that created a packet
In-Reply-To: <20051227014710.43609.qmail@web53708.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0512270925020.10069@yvahk01.tjqt.qr>
References: <20051227014710.43609.qmail@web53708.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> The question is: when do you test for the PID? You would have to do it 
>> within send(), because anywhere else, you do not know. A socket may be 
>> shared among multiple processes (most simple way: fork()).
>
>I'm hooking in NF_IP_LOCAL_OUT of netfilter code using nf_register_hook() function.

In sys_send(), I would have said you could use "current", but in netfilter 
I can't tell exactly whether it is going to work on SMP.

Check net/ipv4/netfilter/ipt_owner.c, it provides a way to match packets vs 
pids, but it's not easy to find out.



Jan Engelhardt
-- 
