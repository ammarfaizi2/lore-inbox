Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTEIL3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTEIL3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:29:39 -0400
Received: from ns.suse.de ([213.95.15.193]:26898 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262456AbTEIL3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:29:04 -0400
Date: Fri, 9 May 2003 13:41:41 +0200
From: Andi Kleen <ak@suse.de>
To: paubert <paubert@iram.es>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>,
       David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] Mask mxcsr according to cpu features.
Message-ID: <20030509114141.GB4254@Wotan.suse.de>
References: <20030509004200.A22795@mrt-lx16.iram.es> <20030509022417.GB15829@Wotan.suse.de> <20030509105622.B16311@mrt-lx16.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509105622.B16311@mrt-lx16.iram.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Clearing the DAZ bit of every 32 bit program as soon
> as it receives a signal can't be right.

No doubt, but changing could still break things. Perhaps there is some 
program that depends on this behaviour (sets the bit by mistake and is 
safed by some signal), and debugging such things is always
nasty. I try to keep the 32bit emulation bug-to-bug compatible to i386

-Andi
