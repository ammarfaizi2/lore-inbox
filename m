Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbUKOUKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUKOUKC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbUKOUHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:07:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:37250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261677AbUKOUFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:05:20 -0500
Date: Mon, 15 Nov 2004 12:05:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Regparm for x86 machine check handlers
In-Reply-To: <4198EA70.202@quark.didntduck.org>
Message-ID: <Pine.LNX.4.58.0411151201580.2222@ppc970.osdl.org>
References: <4198EA70.202@quark.didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Nov 2004, Brian Gerst wrote:
>
> The patch to change traps and interrupts to the fastcall convention 
> missed the machine check handlers.

Thanks, that was silly.

Anybody want to write a script that verifies that the only remaining 
"asmlinkage" entries are of the type "sys_xxxx()"? 

"grep" shows that there's a number of incorrect ones left, but most of 
them seem to take no arguments, so ir doesn't matter. And there's the FP 
emulation stuff, which really -does- use the old interfaces.

		Linus
