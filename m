Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136486AbREAFd5>; Tue, 1 May 2001 01:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136493AbREAFdt>; Tue, 1 May 2001 01:33:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44302 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136486AbREAFde>; Tue, 1 May 2001 01:33:34 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Question about /proc/kmsg semantics..
Date: 30 Apr 2001 22:33:09 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9clhql$lep$1@cesium.transmeta.com>
In-Reply-To: <20010501005237.A2776@sync.nyct.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010501005237.A2776@sync.nyct.net>
By author:    Michael Bacarella <mbac@nyct.net>
In newsgroup: linux.dev.kernel
> 
> I've seen a couple of patches in the archives to make open()/close()
> on /proc/kmsg do more than NOP. As of 2.4.4, klogd still needs to
> run as root since access is checked on read() rather than once at
> open(). I can't find the rationale as to why they're rejected.
> 
> Also, why is reading /proc/kmsg a privileged operation, yet dmesg
> can happily print out the entire ring via (do_)syslog() ?
> 

Probably because reading /proc/kmsg may cause syslogd to miss
messages.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
