Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbTIWTYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTIWTXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:23:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31708 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263490AbTIWTV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:21:56 -0400
Date: Tue, 23 Sep 2003 12:08:56 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       iod00d@hp.com, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923120856.3e538345.davem@redhat.com>
In-Reply-To: <jer8275n8u.fsf@sykes.suse.de>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
	<jehe3372th.fsf@sykes.suse.de>
	<20030923115200.1f5b44df.davem@redhat.com>
	<je4qz3724k.fsf@sykes.suse.de>
	<20030923120110.4a039808.davem@redhat.com>
	<jer8275n8u.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 21:16:33 +0200
Andreas Schwab <schwab@suse.de> wrote:

> Or the compiler generates code to take advantage of the fact that the
> lower address bits are zero.

The only place where I can se it doing this legally is for structure
offsets.  For example where a "load 4 byte word" instruction takes an
offsetable address composed of a reg and an integer offset where the
integer offset must be a multiple of 4.

This rule we do abide by in the kernel, because PARISC requires this.

Anything more is asking for trouble, I wouldn't want to use such a compiler
in the real world :)
