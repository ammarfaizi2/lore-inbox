Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWAKBf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWAKBf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbWAKBf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:35:29 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:6593 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932452AbWAKBf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:35:28 -0500
From: Grant Coady <gcoady@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4: e100 accounting bust for multiple adapters
Date: Wed, 11 Jan 2006 12:35:35 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <cln8s1diqmsei30gqo0dbuv1hclgl4m2lu@4ax.com>
References: <e196s1pj6u4apbjhgdm3imij4a10s6nb87@4ax.com> <4807377b0601101624m1e1eb636q99ae0792b0903c5a@mail.gmail.com>
In-Reply-To: <4807377b0601101624m1e1eb636q99ae0792b0903c5a@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006 16:24:28 -0800, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:

>On 1/9/06, Grant Coady <gcoady@gmail.com> wrote:
>> Hi there,
>>
>> While testing for a different issue on a box with two e100 NICs I noticed
>> that interrupt and other accounting are accumulated to the first e100 NIC.
>
>are the two e100's on the same broadcast domain?  if they are you
>might actually be transferring all traffic on eth0

You ignore the fact these two NICs work as expected on 2.6.15 
and on 2.4.32 when e100 driver is compiled in, for the same 
hardware and test.
>
>e100 doesn't track its own interrupt counts, the kernel does that for us.

What further testing would you like?  Also, you ignore the all 
zeroes ifconfig accounting for the second NIC, and that the 
accounting was also accumulated to the first e100 along with 
interrupts.

Anyway the solution is simple: modular e100 is borked on 2.4, 
compiled in is okay.

Grant.
