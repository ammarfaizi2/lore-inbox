Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTIFWdY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 18:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTIFWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 18:33:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:50306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261896AbTIFWdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 18:33:22 -0400
Message-ID: <33384.4.4.25.4.1062887601.squirrel@www.osdl.org>
Date: Sat, 6 Sep 2003 15:33:21 -0700 (PDT)
Subject: Re: 2.6: spurious recompiles
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <bunk@fs.tum.de>
In-Reply-To: <20030906201417.GI14436@fs.tum.de>
References: <20030906201417.GI14436@fs.tum.de>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When doing a "make" inside an already compiled kernel source there
> shouldn't be anything rebuilt. I've identified three places where this
> isn't the case in recent 2.6 kernels:
>
> 1. ikconfig
>   CC      kernel/configs.o
> even when the .config wasn't changed

This is probably the same thing that Steve Hemminger posted about
yesterday:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106270067411137&w=2

I posted a patch based on Sam Ravnborg's comments that might fix it,
but I haven't verified it yet... The patch is in this message:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106272687506379&w=2

or it may be some other dependency.  I'll look into it.

Thanks,
~Randy



