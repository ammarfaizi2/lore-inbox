Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbTDGU0C (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTDGU0C (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:26:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22290 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261822AbTDGU0B (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 16:26:01 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new syscall: flink
Date: 7 Apr 2003 13:37:19 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6snhv$jba$1@cesium.transmeta.com>
References: <3E90746A.2010300@redhat.com> <b6scsk$18b$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <b6scsk$18b$1@penguin.transmeta.com>
By author:    torvalds@transmeta.com (Linus Torvalds)
In newsgroup: linux.dev.kernel
> 
> As others have pointed out, there is no way in HELL we can do this
> securely without major other incursions.
> 

If so, we already have the security hole... and we need to fix it.

> In particular, both flink() and funlink() require that you do all the
> same permission checks that a real link() or unlink() would do. And as
> some of them are done on the _source_ of the file, that implies that
> they have to be done at open() time.

[f]link() doesn't do any checks that open() doesn't, except for the
O_RDONLY/O_WRONLY/O_RDWR flags.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
