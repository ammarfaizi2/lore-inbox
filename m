Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbTDAVsV>; Tue, 1 Apr 2003 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262654AbTDAVsV>; Tue, 1 Apr 2003 16:48:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17933 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262651AbTDAVsU>; Tue, 1 Apr 2003 16:48:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 64-bit kdev_t - just for playing
Date: 1 Apr 2003 13:59:23 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6d23r$ihn$1@cesium.transmeta.com>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303311039190.5042-100000@serv> <20030331172403.GM32000@ca-server1.us.oracle.com>  <1049208134.19703.12.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1049208134.19703.12.camel@dhcp22.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> We need to default to 12:20 for char but where the 20 is actually
> defaulting to 0000xx so we don't get extra minors for any device
> that hasnt been audited for it
> 

Or 32:32... if we have a hope for that.  Given that the bulk of the
overhead is *already* taken in userspace I still think we should go
all the way on this one.  But yes, we need to make sure old-api
devices get -ENXIO on open anything beyond the 8-bit minor space.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
