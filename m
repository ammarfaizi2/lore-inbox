Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTLOXHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTLOXHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:07:07 -0500
Received: from zero.aec.at ([193.170.194.10]:40458 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263325AbTLOXHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:07:02 -0500
Date: Tue, 16 Dec 2003 00:06:30 +0100
From: Andi Kleen <ak@muc.de>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215230630.GA5872@averell>
References: <12InT-wQ-5@gated-at.bofh.it> <135Nw-5gv-3@gated-at.bofh.it> <137wc-q1-23@gated-at.bofh.it> <m3fzflpwxs.fsf@averell.firstfloor.org> <3FDE3A51.7060802@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDE3A51.7060802@intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 12:48:49AM +0200, Vladimir Kondratiev wrote:

> My fist intention was exactly same as yours, but if all access were done 
> through pci_dev...
> Unfortunately, you can't store ioremap()'ed address for 4k within 
> pci_dev and then simply use it.
> In all places around, config accessed through (bus,dev,fn) indexes.

Just use a small binary tree or hash table to look up the pci_dev
given (bus,dev,fn). That will be much faster than playing with
mappings and flushing TLBs. 
 
-Andi
