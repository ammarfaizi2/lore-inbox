Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTLMBcG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 20:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTLMBcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 20:32:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62994 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262844AbTLMBcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 20:32:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: sysctl vs /proc/sys
Date: 12 Dec 2003 17:31:27 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <brdq5f$9sd$1@cesium.transmeta.com>
References: <20031212.224649.20046672.yoshfuji@linux-ipv6.org> <Xine.LNX.4.44.0312120928120.2843-100000@thoron.boston.redhat.com> <20031212181517.GM15401@matchmail.com> <20031213.094210.107050343.yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031213.094210.107050343.yoshfuji@linux-ipv6.org>
By author:    YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= <yoshfuji@linux-ipv6.org>
In newsgroup: linux.dev.kernel
> 
> Yes, I meant to read old value and to set new one in one system call.
> The sysctl system-call does lock_kernel, so sysctl(2) sytem-call 
> are serialized.
> 

Dumb question... what do you need this for?  sysctl is mostly used to
initialization-time stuff...  In most cases you can use flock(),
probably, although that is advisory and not compulsory.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
