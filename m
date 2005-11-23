Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbVKWAff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbVKWAff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKWAff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:35:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030274AbVKWAfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:35:34 -0500
Date: Tue, 22 Nov 2005 16:35:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-Id: <20051122163550.160e4395.akpm@osdl.org>
In-Reply-To: <20051122125959.GR16080@fi.muni.cz>
References: <20051122125959.GR16080@fi.muni.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@fi.muni.cz> wrote:
>
> I have noticed that on my system kswapd eats too much CPU time every two
> hours or so. This started when I upgraded this server to 2.6.14.2 (was 2.6.13.2
> before), and added another 4 GB of memory (to the total of 8GB).

Next time it happens, please gather some memory info (while it's happening):

	cat /proc/meminfo
	cat /proc/vmstat
	cat /proc/slabinfo
	dmesg -c > /dev/null
	echo m > /proc/sysrq-trigger
	dmesg

Thanks.
