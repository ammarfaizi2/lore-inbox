Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTBFHbg>; Thu, 6 Feb 2003 02:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbTBFHbg>; Thu, 6 Feb 2003 02:31:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:30900 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265667AbTBFHbg>;
	Thu, 6 Feb 2003 02:31:36 -0500
Date: Wed, 5 Feb 2003 23:41:39 -0800
From: Andrew Morton <akpm@digeo.com>
To: Patrick Mau <mau@oscar.ping.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush in D state
Message-Id: <20030205234139.237887a7.akpm@digeo.com>
In-Reply-To: <20030205231259.GA5339@oscar.ping.de>
References: <20030205231259.GA5339@oscar.ping.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2003 07:41:06.0311 (UTC) FILETIME=[1B724970:01C2CDB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mau <mau@oscar.ping.de> wrote:
>
> This goes extremly fast, but after a few seconds pdflush
> gets stuck in D state and tries to write back dirty pages.
> The machine is completly unresponsive and "top" reports
> 75 percent IO wait time. The actual build has not even started.
> 

At a guess, I'd say that a disk device driver has dropped an interrupt and
I/O completion has not happened.

Check your kernel log and dmesg output for anything untoward, and then try
invoking sysrq-P and sysrq-T to find out where everythihg is stuck.

