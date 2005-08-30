Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVH3UjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVH3UjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVH3UjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:39:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932449AbVH3UjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:39:03 -0400
Date: Tue, 30 Aug 2005 13:39:18 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Daniel Drake <dsd@gentoo.org>, Steve Kieu <haiquy@yahoo.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
Message-ID: <20050830133918.42444cae@dxpl.pdx.osdl.net>
In-Reply-To: <4807377b05083013185767744a@mail.gmail.com>
References: <20050830122937.79855.qmail@web53605.mail.yahoo.com>
	<43145FB5.6080300@gentoo.org>
	<4807377b05083013185767744a@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005 13:18:57 -0700
Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:

> on 2.6.11/12 when it isn't working maybe you should send us the output
> of lspci -vvv
> 
> just a hint, I'm guessing its power management related, and / or
> something to do with the pci bus code.

Also, the dmesg output with skge driver will show chip version and revision.
The problem is obviously some of the chip initialization that is complex
with the Marvell chips. Something is probably missing.  There was a fix
in the latest 2.6.13 that is probably related:

	http://www.mail-archive.com/netdev@vger.kernel.org/msg00438.html
