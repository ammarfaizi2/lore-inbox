Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbTDGC0i (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbTDGC0i (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:26:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263196AbTDGC0h (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 22:26:37 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Serial port over TCP/IP
Date: 6 Apr 2003 19:37:57 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6qoa5$edn$1@cesium.transmeta.com>
References: <200304061447.46393.freesoftwaredeveloper@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200304061447.46393.freesoftwaredeveloper@web.de>
By author:    Michael Buesch <freesoftwaredeveloper@web.de>
In newsgroup: linux.dev.kernel
> 
> Is it possible to make a char-dev (a serial device ttyS0)
> available via TCP/IP on a network like it is possible
> for block-devices like a harddisk via nbd?
> Is kernel-support for this present?
> If not, is it technically possible to develop such a driver?
> 

I think what you need is the enhanced pty driver patch which was
posted recently, which made is possible for a user-space process to
also capture ioctls() such as baud rate setting etc.  Then the rest of
the work can be done in userspace.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
