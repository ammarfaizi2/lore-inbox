Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbTJUVMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbTJUVMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:12:09 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:5138 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263352AbTJUVMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:12:05 -0400
Date: Tue, 21 Oct 2003 23:21:36 +0200
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031021212136.GA15043@hh.idb.hist.no>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <bn42vk$ies$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bn42vk$ies$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 07:55:32PM +0000, bill davidsen wrote:

> Your argument is correct, but this is data generation rather than
> analysis. In doing simulation it's desirable to ensure that multiple
> instances of a program don't use the same numbers.
> 
> For instance, simulating user load against a server; I want the
> simulation of human thinking time to be a number in the range n..m and
> not to be the same for all threads. Sure I can get around that, and do,
> but I wouldn't mind having a simple source of random bytes which was
> quality PRNG and unique.

Each thread use the same userspace pseudo-random generator (faster
than any kernel implementation as you avoid the syscalls) and
each initialize by a single read from urandom, so they get
different series of numbers.

Helge Hafting
