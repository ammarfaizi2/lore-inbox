Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTDNWMT (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbTDNWKf (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:10:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17933 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263979AbTDNWKA (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:10:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [vgacon] Font height discrepancy, Linux 2.5.x
Date: 14 Apr 2003 15:21:38 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7fc9i$sso$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0304141712330.28989-100000@winds.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0304141712330.28989-100000@winds.org>
By author:    Byron Stanoszek <gandalf@winds.org>
In newsgroup: linux.dev.kernel
> 
> I would only like to set vc_font.height on all VTs if the underlying module is
> a VGA Console and not a framebuffer.
> 
> What is the easiest way to do this? Perhaps the module should set a special
> flag in the vt structure to determine if a font change affects all VTs (as in
> the VGA Console) or only on the current VT (Framebuffer)?
> 

I think we need a font data structure that is pointed to by the vc
data structure.  It can be shared for those consoles where it's
appropriate and separate for those that aren't.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
