Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVCTGqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVCTGqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 01:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVCTGqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 01:46:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:46043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262019AbVCTGqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 01:46:06 -0500
Date: Sat, 19 Mar 2005 22:45:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bob Gill <gillb4@telusplanet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nasty ReiserFS bug in 2.6.12-rc1, 2.6.12-rc1-bk1
Message-Id: <20050319224549.50ebd7b2.akpm@osdl.org>
In-Reply-To: <1111267079.7961.10.camel@localhost.localdomain>
References: <1111267079.7961.10.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Gill <gillb4@telusplanet.net> wrote:
>
> Hi.  I have built 2.6.12-rc1 and 2.6.12-rc1-bk1.  There seems to be a
> nasty bug in ReiserFS (things are fine in 2.6.11.4).

Looks like the problem lies elsewhere.

>  The system wants
> to un-configure my SCSI Adaptec devices, and stall at "starting Hal
> daemon".

What does this mean?  Please provide (much) more detail.

> Mar 19 12:25:13 localhost kernel: EIP is at as_find_arq_hash+0x38/0x7d

At a guess I'd say that scsi did something horrid and tripped up the
anticipatory scheduler code.

