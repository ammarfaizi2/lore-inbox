Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266529AbUBRXa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUBRXaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:30:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:31361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266666AbUBRX3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:29:32 -0500
Date: Wed, 18 Feb 2004 15:29:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix microcode change for i386
In-Reply-To: <20040219011159.6f60aa69.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0402181528250.18038@home.osdl.org>
References: <20040219011159.6f60aa69.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Andi Kleen wrote:
> 
> This patch should fix the i386 compile problem in the microcode driver I caused with
> the IA32e updates.

I doubt it. Doing a ">>32" on an "unsigned long" on x86 should give you a 
warning about undefined behaviour.

See the patch I posted, which should be safe, afaik.

		Linus
