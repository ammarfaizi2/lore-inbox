Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTDQTuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTDQTuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:50:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34820 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262100AbTDQTuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:50:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [BK+PATCH] remove __constant_memcpy
Date: 17 Apr 2003 13:01:52 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7n17g$dlp$1@cesium.transmeta.com>
References: <3E9DFC11.50800@pobox.com> <1050585430.31390.32.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1050585430.31390.32.camel@dhcp22.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> You are assuming the compiler is smart about stuff - it doesnt know
> SSE/MMX for page copies etc. For small copies it should alays win, but
> isn't it best if so to use __builtin_memcpy without our existing
> macros not just trust the compiler ?
> 

For large or variable-sized copies __builtin_memcpy() just generates a
call to memcpy().  What's more, if you don't specify
-fno-builtin-memcpy memcpy() defaults to __builtin_memcpy()
automatically unless you override it (which Linux does with its
macros.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
