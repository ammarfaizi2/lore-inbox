Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTLKNwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTLKNwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:52:32 -0500
Received: from ee.oulu.fi ([130.231.61.23]:33458 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264949AbTLKNw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:52:29 -0500
Date: Thu, 11 Dec 2003 15:52:24 +0200 (EET)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: James Bourne <jbourne@hardrock.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: computer hangs with 2.4.23 (2.4.22 works)
In-Reply-To: <Pine.LNX.4.51.0312090752320.31228@cafe.hardrock.org>
Message-ID: <Pine.GSO.4.58.0312111544310.17042@stekt37>
References: <Pine.GSO.4.58.0312091309090.15061@stekt37>
 <Pine.LNX.4.51.0312090752320.31228@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, James Bourne wrote:

>On Tue, 9 Dec 2003, Tuukka Toivonen wrote:
>> Computer hangs after few hours of uptime

>You have CONFIG_IP_NF_COMPAT_IPCHAINS as a module, are you using ipchains
>compatibility?

Yes indeed I am.

>http://www.hardrock.org/kernel/current-updates/linux-2.4.23-updates.patch
>and see if that makes a difference for you.  It contains the ipchains compat
>oops amoung other patches.

Looks like this patch fixed the problem. Since I applied this patch two
days ago, the computer hasn't crashed (yesterday or today).

>http://www.kernel.org/pub/linux/kernel/v2.4/snapshots/patch-2.4.23-bk5.bz

I can't get this link to work... but I don't then need it.

Some more facts which clearly point into ipchains problem:
This computer has two network cards, another connected to the Internet,
another to a laptop. The ipchains is used to allow the laptop to access
Internet. The laptop generally doesn't do that, except at 13:00 when a cron
job runs ntpdate, and now that I think it, the crash happened probably
every day soon after 13:00 (but not exactly, I believe).

Thanks.

