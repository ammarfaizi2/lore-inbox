Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVAQFna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVAQFna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 00:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVAQFna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 00:43:30 -0500
Received: from mail.suse.de ([195.135.220.2]:41897 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262696AbVAQFn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 00:43:28 -0500
Date: Mon, 17 Jan 2005 06:43:22 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       manpreet@fabric7.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-ID: <20050117054322.GD19187@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de> <1105929264.3954.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105929264.3954.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 01:34:24PM +1100, Rusty Russell wrote:
> On Sat, 2005-01-15 at 05:09 +0100, Andi Kleen wrote:
> > Fix boot up SMP race in timer setup on i386/x86-64.
> 
> How's this?  Didn't do x86-64, but tested on i386.

Looks ok to me. You're right that the commenced check should
do the necessary synchronization before the idle loop
is entered.

-Andi
