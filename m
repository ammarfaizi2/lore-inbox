Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276826AbRJMKLH>; Sat, 13 Oct 2001 06:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276828AbRJMKK4>; Sat, 13 Oct 2001 06:10:56 -0400
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:17841 "EHLO
	stud.fbi.fh-darmstadt.de") by vger.kernel.org with ESMTP
	id <S276826AbRJMKKn>; Sat, 13 Oct 2001 06:10:43 -0400
Date: Sat, 13 Oct 2001 12:07:48 +0200 (CEST)
From: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
To: Andi Kleen <ak@muc.de>
cc: <linux-kernel@vger.kernel.org>, <Matt_Domsch@dell.com>
Subject: Re: crc32 cleanups
In-Reply-To: <k2het3luxj.fsf@zero.aec.at>
Message-ID: <Pine.LNX.4.30.0110131202070.1076-100000@stud.fbi.fh-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That doesn't solve the problem, if your kernel doesn't use the crc
functions but an externel one (special driver - eventually binary) module
needs the code. The external driver may give a message like "crc functions
needed - please recompile your kernel with crc support". Is this ok for
the normal user ?

> Just use the existing linker features. Link the crc code as an .a library.
> If some code needs it it'll get included. If it needs initialization
> use the existing __initcall() setup. It'll generate a call to the
> initialization function when it is linked in, and none if it is not.
>
> [Note that __initcall may be a bit tricky here if some other __initcall
> user like an ethernet driver needs crc32 too; there is unfortunately no
> priority mechanism in __initcall to enforce that the crc32 init runs before
> the other initcalls. best would probably just to use a static table to avoid
> this issue]

Jan-Marek

