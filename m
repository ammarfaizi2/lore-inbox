Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319021AbSIDCtH>; Tue, 3 Sep 2002 22:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319022AbSIDCtH>; Tue, 3 Sep 2002 22:49:07 -0400
Received: from holomorphy.com ([66.224.33.161]:53410 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319021AbSIDCtG>;
	Tue, 3 Sep 2002 22:49:06 -0400
Date: Tue, 3 Sep 2002 19:46:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Important per-cpu fix.
Message-ID: <20020904024630.GU888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20020904023535.73D922C12D@lists.samba.org> <3D75766F.1ED7257D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D75766F.1ED7257D@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>> Frankly, I'm amazed the kernel worked for long without this.
>> Every linker script thinks the section is called .data.percpu.
>> Without this patch, every CPU ends up sharing the same "per-cpu"
>> variable.

On Tue, Sep 03, 2002 at 07:56:47PM -0700, Andrew Morton wrote:
> wow.  Either this was working by fluke, or Bill's softirq problem
> just got solved.

It's pretty easy to find out, my machines don't get past
execve("/sbin/init", argv_init, envp_init); without some kind of softirq
fix. The boot cycle is not swift though... in progress.


Cheers,
Bill
