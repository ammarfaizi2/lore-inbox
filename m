Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWBGJkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWBGJkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWBGJky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:40:54 -0500
Received: from ns1.suse.de ([195.135.220.2]:11198 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932460AbWBGJkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:40:36 -0500
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
Date: Tue, 7 Feb 2006 10:25:39 +0100
User-Agent: KMail/1.8.2
Cc: sfr@canb.auug.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
References: <20060207105631.39a1080c.sfr@canb.auug.org.au> <20060206.160140.59716704.davem@davemloft.net>
In-Reply-To: <20060206.160140.59716704.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071025.40130.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 01:01, David S. Miller wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 7 Feb 2006 10:56:31 +1100
> 
> > This adds compat version of all the remaining *at syscalls
> > so that the "dfd" arguments can be properly sign extended.
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> I do the sign extension with tiny stubs in arch/sparc64/kernel/sys32.S
> so that the arg frobbing does not consume a stack frame, which is what
> happens if you do this in C code.

To be honest - do you really think that matters? Even a Niagara will
go through that in no time @)

And on x86-64 it should be as efficient as an equivalent assembly function.

-Andi
