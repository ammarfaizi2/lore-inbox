Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTIHOW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTIHOV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:21:26 -0400
Received: from havoc.gtf.org ([63.247.75.124]:36303 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262408AbTIHOVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:21:20 -0400
Date: Mon, 8 Sep 2003 10:21:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] caller-save/callee-save register styles
Message-ID: <20030908142115.GA3497@gtf.org>
References: <Pine.LNX.4.44.0309072348090.16598-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309072348090.16598-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 11:54:59PM +0530, Nagendra Singh Tomar wrote:
> I would like to know various people's experiences about the caller-save 
> and callee-save style of preserving register values across procedure 
> calls. I feel that the ABI specification should specify that but I was 
> unable to figure that out in the ELF-ABI specification.

The i386 ELF ABI spec _does_ specify that.


> What I have personally seen is only callee-save style in which the 
> modified registers are PUSHed on the stack on entering the function and 
> POPed on leaving the function. That means the caller can assume that all 
> the regsiter values will be same just before and after the 'call' 
> instruction.

The caller assumes nothing; the caller is _guaranteed_ the register
rules described in the i386 ELF ABI.

Compiler writers will sometimes simply avoid registers they must save
and restore across function calls.  That allows them to avoid push'ing
and pop'ing outside of calling another function.

	Jeff



