Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268834AbUINCWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268834AbUINCWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUINCUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:20:42 -0400
Received: from holomorphy.com ([207.189.100.168]:2704 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269117AbUINCRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:17:38 -0400
Date: Mon, 13 Sep 2004 19:14:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Richard Henderson <rth@twiddle.net>
Cc: Hanna Linder <hannal@us.ibm.com>, ink@jurassic.park.msu.ru,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_alcor.c] [1/2] convert pci_find_device to pci_get_device
Message-ID: <20040914021412.GK9106@holomorphy.com>
References: <806400000.1095118633@w-hlinder.beaverton.ibm.com> <20040914020116.GA23058@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914020116.GA23058@twiddle.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 04:37:13PM -0700, Hanna Linder wrote:
>> Here is a very simple patch to convert pci_find_device call to pci_get_device.
>> As I don't have an alpha box or cross compiler could someone (wli- wink wink)
>> please verify it compiles and doesn't break anything, thanks a lot.

On Mon, Sep 13, 2004 at 07:01:16PM -0700, Richard Henderson wrote:
> Presumably the intent is to eventually remove pci_find_device?
> These routines run at the very beginning of bootup; there cannot
> possibly be any races.

I think it's okay if the intent is to remove pci_find_device() entirely
so drivers etc. don't trip over it. The bootstrap changes are, I
suppose, only to enable the eventual removal, and not meant to resolve
races that may exist there per se.


-- wli
