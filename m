Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUDXEd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUDXEd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 00:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUDXEd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 00:33:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:8904 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261920AbUDXEd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 00:33:56 -0400
Subject: Re: Si3112 S-ATA bug preventing use of udma5.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: Brenden Matthews <brenden@rty.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <52ad12qf8u.fsf@topspin.com>
References: <42822.68.144.162.3.1082757748.squirrel@webmail.rty.ca>
	 <1082771045.10727.46.camel@gaston>  <52ad12qf8u.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1082781068.10628.51.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Apr 2004 14:31:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-24 at 12:30, Roland Dreier wrote:

> Finally, siimage.c does
> 
>                 hwif->OUTW(speedt, addr);
> 
> and speedt is a u32 -- however, as you say, the compiler should just
> cast speedt down to a u16.  What am I missing?

This is just a normal function call, there should be nothing special,
so either you are missing something else or you are suffering from
incorrectly compiled code... I'm no x86 expert so I can't help
analyzing the codegen here though.

Ben.


