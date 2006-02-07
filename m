Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWBGTRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWBGTRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 14:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWBGTRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 14:17:21 -0500
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:12898 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965122AbWBGTRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 14:17:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AIH64IODrMXZYk/E5a2PvTMcQovbE6khgD2vhJCSSlPyDYNRHlT04yR/kd0YYC93vv1WRCbOnWLng5u9TLe8NgzWzUo5TC1MRU4BpJWkjDAgnbIPS69giom3F0ArQi7G30+9XuOt1PZQQetnWUG+Mf55GCVZHPNXvf+IzWj4vVc=  ;
Message-ID: <20060207191717.25539.qmail@web31804.mail.mud.yahoo.com>
Date: Tue, 7 Feb 2006 11:17:17 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] x86-64: improve the format of stack dumps
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, rdunlap@xenotime.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200602071020.47999.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andi Kleen <ak@suse.de> wrote:
> On Tuesday 07 February 2006 06:13, Luben Tuikov wrote:
> > Improve the format of stack dumps for x86-64.
> > * Single column of stack entries. (similar to other arches)
> 
> I don't like that part as I wrote earlier.It's a waste of precious
> screen space, no matter how often you retransmit the patch.  The old
> format had a chance to even fit on a 80x25 screen, with your new one
> it is extremly unlikely.
> 
> Overall you're making less information available in a common case
> for cosmetics.

And as I wrote earlier, this patch doesn't only improve output,
it also _reuses_ code, i.e. __print_symbol() which your code recreates
in printk_address().  Now printk_address() reuses the common __print_symbol().

One very important thing this patch also does is that it prints the offsets
in hexadecimal, as opposed to decimal.  I.e. from

0xNNNNNNNN+DDD to 0xNNNNNNNNN+0xTTT/0xWWW

As to "less space", this patch prints _identical_ information as the code
before it, as I'm sure you can see by reading the patch itself.

Thanks,
     Luben


