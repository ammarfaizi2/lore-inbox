Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTKXGEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 01:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTKXGEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 01:04:10 -0500
Received: from holomorphy.com ([199.26.172.102]:26552 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263571AbTKXGEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 01:04:01 -0500
Date: Sun, 23 Nov 2003 22:03:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: John Smith <penguin2047@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PTE --> 2 values??
Message-ID: <20031124060357.GW22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Smith <penguin2047@hotmail.com>, linux-kernel@vger.kernel.org
References: <BAY10-DAV61cvpzTHkz0000160a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY10-DAV61cvpzTHkz0000160a@hotmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 23, 2003 at 11:50:15PM -0500, John Smith wrote:
> I saw that Linux is using a 3 level page tables, pgd, pmd and pte. The value
> in the pte can refer to an actual page in memory OR an address on the swap
> device. How does the kernel distinguish the two values such that if the
> value is refering to an swap device address, it will not lookup the address
> in memory ??

There is a present bit. All other bits are available to the OS when the
present bit says "not present". On many machines, Linux' 3-level tree is
a pure software construct, and the processor is informed of translations
in other ways (e.g. inverted pagetables, direct TLB insertion).


-- wli
